//
//  ViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/11.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //设置不让系统自动控制scrollView的contenInsets
        self.automaticallyAdjustsScrollViewInsets = false
        //封装返回按钮
        self.configureBackItem()
        //设置控制器的背景颜色
        self.view.backgroundColor = UIColor.randomColor()
    }
    func configureBackItem(){
        //如果时push的控制器，那么返回按钮相应的事pop 否则事dismiss
        if (self.navigationController?.presentingViewController == nil
            && self.navigationController?.viewControllers.first != self)
            || self.navigationController?.presentingViewController != nil
        {
            
                let backBtn = UIButton(type: .Custom)
                backBtn.setImage(UIImage(named: "返回按钮"), forState: .Normal)
                backBtn.jk_handleControlEvents(.TouchUpInside, withBlock: { (sender) in
                    
                    if self.navigationController?.popViewControllerAnimated(true) == nil{
                        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                })
                backBtn.frame = CGRectMake(0, 0, 24, 32)
                let backItem = UIBarButtonItem(customView: backBtn)
                self.navigationItem.leftBarButtonItem = backItem
            
        }else{
            //self.hidesBottomBarWhenPushed = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }


}
//封装一个分类，方便获取tabBar navigationBar statusBar 等的高度
extension UIViewController{
    var statusBarHeight:CGFloat{
        return UIApplication.sharedApplication().statusBarFrame.size.height
    }
    var navBarHeight:CGFloat{
        return (self.navigationController?.navigationBar.frame.size.height)!
    }
    var tabBarHeight:CGFloat{
        if self.hidesBottomBarWhenPushed == true{
            return (self.tabBarController?.tabBar.frame.size.height)!
        }else{
            return 0
        }
    }
    var topBarHeight:CGFloat{
        return statusBarHeight + navBarHeight
    }
}
