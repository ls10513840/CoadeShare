//
//  CSRegisterViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/11.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import Alamofire
class CSRegisterViewController: UIViewController {

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
        codeBtn.setTitleColor(UIColor.greenColor(), forState: .Normal)
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
        
       let registerBtn = UIButton(type:.Custom)
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        registerBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        registerBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        registerBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: ["service":"User.Register",
                 "phone":userName.text!,
                "password":password.text!,
                "verificationCode":code.text!
                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        print(response.result.value)
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        print("网络请求失败")
                    }
                })
        }
        self.view.addSubview(registerBtn)
        registerBtn.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(52)
            make.top.equalTo(code.snp_bottom).offset(120)
        }
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
