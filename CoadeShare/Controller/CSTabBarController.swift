//
//  CSTabBarController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/11.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureControllers()
    }
    func configureControllers(){
        let vcInfos = [
            ["title":"主页",
                "image":"按钮主页",
                "class":"CoadeShare.CSMainViewController"],
            ["title":"消息",
                "image":"按钮消息",
                "class":"CoadeShare.CSscrollerViewController"],
            ["title":"分享",
                "image":"按钮分享",
                "class":"CoadeShare.CSShareViewController"],
            ["title":"我的",
                "image":"按钮我的",
                "class":"CoadeShare.CSMyInfoViewController"]
        ]
        var vcArray:[UINavigationController] = []
        for vcInfo in vcInfos{
            let vc = (NSClassFromString(vcInfo["class"]!) as! UIViewController.Type).init()
            vc.title = vcInfo["title"]
            
            let navVC = UINavigationController.init(rootViewController: vc)
            vcArray.append(navVC)
        }
        self.viewControllers = vcArray
        var i = 0
        for tabBarItem in self.tabBar.items!{
            
            tabBarItem.image = UIImage(named: vcInfos[i]["image"]!)
            i += 1
        }
        //设置选中状态下的tabBar的颜色
        self.tabBar.tintColor = UIColor(red: 0.5088, green: 0.7682, blue: 0.1978, alpha: 1.0)
        
    }
    override func viewDidAppear(animated: Bool) {
        //重写控制器的生命周期方法时，调用父类实现
        super.viewDidAppear(animated)
        //当用户未登陆时才弹出登陆界面
        if CSUserModel.isLogin() == false{
            let loginVC = UINavigationController.init(rootViewController: CSLoginViewController.init())
            self.presentViewController(loginVC, animated: true, completion: nil)
           
        }
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
