//
//  CSLoginViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/11.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import SnapKit
import JKCategories
import Alamofire
class CSLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "登陆"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let userName = UITextField.init()
        userName.placeholder = "输入邮箱或手机号码"
        userName.font = UIFont.systemFontOfSize(15)
        userName.backgroundColor = UIColor.whiteColor()
        // 用SnapKit／masonry 给视图添加约束
        self.view.addSubview(userName)
        //设置约束必须要能唯一确定视图的位置和大小
        userName.snp_makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(48)
        }
        //设置输入框的边框
        userName.layer.borderColor = UIColor.grayColor().CGColor
        userName.layer.borderWidth = 1.0
        
        let password = UITextField.init()
        password.placeholder = "输入密码"
        password.font = UIFont.systemFontOfSize(15)
        password.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(password)
        //密码框的约束
        password.snp_makeConstraints { (make) in
            make.top.equalTo(userName.snp_bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(48)
            
        }
        password.layer.borderColor = UIColor.grayColor().CGColor
        password.layer.borderWidth = 1.0
        
        //设置输入框左边图片
        let nameLeft = UIView()
        let passLeft = UIView()
        let nameImage = UIImageView.init(image: UIImage(named: "用户图标"))
        nameLeft.addSubview(nameImage)
        userName.leftView = nameLeft
        userName.leftViewMode = UITextFieldViewMode.Always
        nameLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(64, 48))
        }
        nameImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        let passImage = UIImageView(image: UIImage(named: "密码图标"))
        passLeft.addSubview(passImage)
        password.leftView = passLeft
        password.leftViewMode = UITextFieldViewMode.Always
        passLeft.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(64, 48))
        }
        passImage.snp_makeConstraints { (make) in
            make.center.equalTo(0)
        }
        password.secureTextEntry = true
        
        
        let forgetPass = UIButton(type: .Custom)
        forgetPass.titleLabel?.font = UIFont.systemFontOfSize(15)
        forgetPass.setTitle("忘记密码?", forState: .Normal)
        forgetPass.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.view.addSubview(forgetPass)
        forgetPass.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(password.snp_bottom)
            make.width.equalTo(80)
            make.height.equalTo(56)
        }
        //登陆按钮
        let loginBtn = UIButton(type: .Custom)
        loginBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        loginBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginBtn.setTitle("登陆", forState: .Normal)

        //loginBtn.backgroundColor = UIColor.init(red: 0.6, green: 0.8, blue: 0.6, alpha: 1)
        loginBtn.jk_setBackgroundColor(UIColor.greenColor(), forState: .Normal)
        loginBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Disabled)
        loginBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        loginBtn.jk_handleControlEvents(UIControlEvents.TouchUpInside) { (sender) in
            Alamofire.request(.POST, "https://www.1000phone.tk", parameters: ["service":"User.Login",
                "phone":userName.text!,
                "password":password.text!,
                ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: { (response) in
                    if response.result.isSuccess {
                        print(response.result.value)
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        print("网络请求失败")
                    }
                })
        }
        
        self.view.addSubview(loginBtn)
        loginBtn.snp_makeConstraints { (make) in
            make.right.left.equalTo(0)
            make.top.equalTo(forgetPass.snp_bottom).offset(100)
            make.height.equalTo(48)
        }
        
        let backBtn = UIButton(type: .Custom)
        backBtn.setImage(UIImage(named:"返回按钮"), forState: .Normal)
        let backBarBtn = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backBarBtn
        backBtn.frame = CGRectMake(0, 0, 24, 32)
        
        let registerBtn = UIButton(type: .Custom)
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        let registerBarBtn = UIBarButtonItem(customView: registerBtn)
        self.navigationItem.rightBarButtonItem = registerBarBtn
        registerBtn.frame = CGRectMake(0, 0, 44, 32)
        
        backBtn.addTarget(self, action: #selector(backAction), forControlEvents: .TouchUpInside)
        registerBtn.addTarget(self, action: #selector(registerAction), forControlEvents: .TouchUpInside)
    }
    func backAction(){
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func registerAction(){
        let registerCtrl = CSRegisterViewController()
        self.navigationController?.pushViewController(registerCtrl, animated: true)
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
