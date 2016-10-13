//
//  CSRegisterViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/11.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveCocoa

class CSRegisterViewController: ViewController {
    
    dynamic var time = -1
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "注册"
        // Do any additional setup after loading the view.
        let userName = UITextField()
        userName.font = UIFont.systemFontOfSize(15)
        userName.placeholder = "输入邮箱或者手机号"
        userName.layer.borderColor = UIColor.grayColor().CGColor
        userName.layer.borderWidth = 1
        self.view.addSubview(userName)
        userName.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(100)
            make.height.equalTo(48)
        }
        
        let leftView = UIView()
        let leftImage = UIImageView(image: UIImage(named: "手机邮箱图标"))
        leftView.addSubview(leftImage)
        userName.leftView = leftView
        userName.leftViewMode = UITextFieldViewMode.Always
        leftView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(64, 48))
        }
        leftImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
       
        let password = UITextField()
        password.font = UIFont.systemFontOfSize(15)
        password.placeholder = "请输入密码"
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.secureTextEntry = true
        self.view.addSubview(password)
        password.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(48)
            make.top.equalTo(userName.snp_bottom)
        }
        let leftPass = UIView()
        let leftPassIamge = UIImageView(image: UIImage(named: "密码图标"))
        password.leftView = leftPass
        password.leftViewMode = UITextFieldViewMode.Always
        leftPass.addSubview(leftPassIamge)
        leftPass.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(64, 48))
        }
        
        leftPassIamge.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
   
        let code = UITextField()
        code.font = UIFont.systemFontOfSize(15)
        code.placeholder = "请输入验证码"
        code.layer.borderWidth = 1
        code.layer.borderColor = UIColor.grayColor().CGColor
        self.view.addSubview(code)
        code.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(48)
            make.top.equalTo(password.snp_bottom).offset(10)
        }
        
        let leftCode = UIView()
        let leftCodeImage = UIImageView(image: UIImage(named: "验证信息图标"))
        leftCode.addSubview(leftCodeImage)
        code.leftView = leftCode
        code.leftViewMode = UITextFieldViewMode.Always
        leftCode.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(64, 48))
        }
        
        leftCodeImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        let codeRight = UIView()
        let codeBtn = UIButton(type: .Custom)
        codeBtn.setTitle("获取验证码", forState: .Normal)
        codeBtn.setTitleColor(UIColor.redColor(), forState: .Normal)
        
        codeBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        codeBtn.layer.borderColor = UIColor.grayColor().CGColor
        codeBtn.layer.borderWidth = 1
        codeBtn.layer.cornerRadius = 3.0
        codeBtn.layer.masksToBounds = true
        codeBtn.addTarget(self, action: #selector(codeAction), forControlEvents: .TouchUpInside)
        code.rightView = codeRight
        code.rightViewMode = UITextFieldViewMode.Always
        codeRight.addSubview(codeBtn)
        codeRight.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(120, 48))
        }
        codeBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.left.equalTo(8)
            make.top.equalTo(4)
        }
        
        codeBtn.enabled = false
        codeBtn.jk_setBackgroundColor(UIColor.yellowColor(), forState: .Normal)
        codeBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Disabled)
        codeBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
      /*
        userName.jk_handleControlEvents(UIControlEvents.EditingChanged) { (sender) in
            code.enabled = userName.text?.lengthOfBytesUsingEncoding(NSStringEncoding.init(NSUTF8StringEncoding)) == 11
        }
        */
        userName.rac_textSignal().subscribeNext { (sender) in
            //用rac订阅输入框改变的信号，根据输入内容，改变按钮状态
            let name = sender as! NSString
            codeBtn.enabled = name.length == 11 && self.time == -1
            if name.length >= 11{
               // password.becomeFirstResponder()
            }
        }
      

        
        //将几个信号合并为一个信号订阅并改变注册按钮的状态
        //获取验证码
        // 使用mvc思想如果数据改变，界面跟着改变
        self.rac_valuesForKeyPath("time", observer: self).subscribeNext { (time) in
            codeBtn.enabled = self.time == -1
            if self.time == -1{
                if self.timer != nil{
                   self.timer.invalidate()
                }
                
                codeBtn.setTitle("获取验证码", forState: .Normal)
            }else{
                codeBtn.setTitle("还剩\(self.time)秒", forState: .Normal)
            }
        }
        codeBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            self.time = 60
            
            SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethod.init(0), phoneNumber: userName.text, zone: "86", customIdentifier: nil) { (error) in
                if error != nil{
                    // 让time重置为－1 如果现在符合条件按钮正常
                    self.time = -1
                }else{
                    //一开始让time＝－1 （即正常状态，按钮可用）
                    //当点击获取验证码按钮时让time＝ 60 并每秒递减1，当减到－1时读秒结束
                    //可用监控的方式改变按钮状态
                    self.timer = NSTimer.jk_scheduledTimerWithTimeInterval(1, block: {
                        self.time = self.time - 1
                        }, repeats: true) as! NSTimer
                    
                }
            }
        }
        
        //注册
       let registerBtn = UIButton(type:.Custom)
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        registerBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        registerBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
//            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: ["service":"User.Register",
//                 "phone":userName.text!,
//                "password":(password.text! as NSString).jk_md5String,
//                "verificationCode":code.text!
//                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
//                    if response.result.isSuccess {
//                        print(response.result.value)
//                        self.navigationController?.popViewControllerAnimated(true)
//                    }else{
//                        print("网络请求失败")
//                    }
//                })
            CSNetHelp.request(parameters: ["service":"User.Register",
                "phone":userName.text!,
                "password":(password.text! as NSString).jk_md5String,
                "verificationCode":code.text!
                ]).responseJSON({ (data, success) in
                    if success {
                        print("1")
                    }else{
                        dispatch_async(dispatch_get_main_queue(), { 
                            UIAlertView(title: "错误", message: data as? String, delegate: nil, cancelButtonTitle: "我知道了").show()
                        })
                        
                    }
                })
        }
        //在做一些关于用户敏感信息的数据交互时，一般都要对数据进行加密  Md5严格来讲 并不属于加密算法，因为MD5并没有解密过程，只是对数据进行提取特征加密，会破坏原数据的意义。   所以一般加密密码会用MD5，这样服务器人员，公司内部人员，也不知道你密码。
        //为了更安全，我们会对原始的字符串进行加盐，再次MD5加密
        
        //RAS DES...这些加密算法可以通过密钥解密出原始数据，所以出了密码之外的一些信息，可以用这种加密方式
        
        self.view.addSubview(registerBtn)
        registerBtn.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(52)
            make.top.equalTo(code.snp_bottom).offset(120)
        }
        registerBtn.enabled = false
        
        userName.rac_textSignal()
        .combineLatestWith(password.rac_textSignal())
        .combineLatestWith(code.rac_textSignal())
        .subscribeNext { (sender) in
            registerBtn.enabled = ((userName.text! as NSString).length == 11 && (password.text! as NSString).length >= 6 && (code.text! as NSString).length == 4)
        }
        /*
        //热信号实现需求
        userName.rac_textSignal().toSignalProducer()
        .combineLatestWith(password.rac_textSignal().toSignalProducer())
        .combineLatestWith(code.rac_textSignal().toSignalProducer())
        .startWithNext { (signal1, signal2) in
            
        }
        */
        registerBtn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (sender) in
            //print(sender as! UIButton)
        }
        //将变量的改变量作为信号来订阅
        
        //处理键盘遮挡视图的问题
        //用RAC 代替通知
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil)
        .subscribeNext { (noti) in
            //取出通知携带的键盘的信息
            let userInfo = (noti as! NSNotification).userInfo
            
            let rect = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
            //用SnapKit、给注册按钮做一个动画
            //如果更改一个视图的约束，需要用snp_update(必须是前面已经make过的)
            registerBtn.snp_updateConstraints(closure: { (make) in
                make.top.equalTo(code.snp_bottom).offset(50)
            })
            UIView.animateWithDuration(0.25, animations: { 
                registerBtn.layoutIfNeeded()
            })
        }
        //当键盘消失，我们只需要将约束更新为原始状态即可
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillHideNotification, object: nil)
        .subscribeNext { (noti) in
            registerBtn.snp_updateConstraints(closure: { (make) in
                make.top.equalTo(code.snp_bottom).offset(120)
            })
            UIView.animateWithDuration(0.25, animations: {
                registerBtn.layoutIfNeeded()
            })
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func codeAction(){
        
    }
    func registerAction(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
