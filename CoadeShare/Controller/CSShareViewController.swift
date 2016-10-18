
//
//  CSShareViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import YYKit
import FDFullscreenPopGesture
class CSShareViewController: CSscrollerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        
        let backImage = UIImage(named: "美女21")
        self.view.backgroundColor = UIColor(patternImage: backImage!)
        //直接可以这样很方便的给某个view加一个模糊效果
        let toolBar = UIToolbar()
        //self.view.addSubview(toolBar)
        
        self.view.insertSubview(toolBar, atIndex: 0)
        toolBar.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        let topButton = UIButton(type: .Custom)
        topButton.setImage(UIImage(named:"按钮-图片"), forState: .Normal)
        self.contentView.addSubview(topButton)
        topButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(-120)
            make.centerX.equalTo(0)
            make.width.height.equalTo(56)
        }
        let centerBtn = UIButton(type:.Custom)
        centerBtn.setImage(UIImage(named: "按钮-视频"), forState: .Normal)
        self.contentView.addSubview(centerBtn)
        centerBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.width.height.equalTo(topButton)
        }
        let bottomBtn = UIButton(type: .Custom)
        bottomBtn.setImage(UIImage(named: "按钮-压缩包"), forState: .Normal)
        self.contentView.addSubview(bottomBtn)
        bottomBtn.snp_makeConstraints { (make) in
            make.width.height.equalTo(topButton)
            make.centerX.equalTo(0)
            make.centerY.equalTo(140)
        }
        
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        //跳转到分享图片等控制器
        topButton.jk_handleControlEvents(.TouchUpInside) { (sender) in
            let sharePhoto = CSSharePhotoViewController()
            sharePhoto.title = "图片分享"
            sharePhoto.hidesBottomBarWhenPushed = true
            sharePhoto.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
            self.navigationController?.pushViewController(sharePhoto, animated: true)
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
