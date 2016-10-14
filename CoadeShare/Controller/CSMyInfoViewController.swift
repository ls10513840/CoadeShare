//
//  CSMyInfoViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/14.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMyInfoViewController: CSscrollerViewController {
    var dispalyController = YZDisplayViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //封装展示多个子控制器
        self.configureViewControllers()
        self.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.configureTitleScroll()
        
        //设置上半部分的展示界面
        self.configureTopInfo()
    }
    func configureTopInfo(){
        let backImage = UIImageView(image: UIImage(named: "背景图片"))
        self.contentView.addSubview(backImage)
        backImage.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(180)
        }
        let headImage = UIImageView(image: UIImage(named: "头像"))
        backImage.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.left.top.equalTo(16)
            make.width.height.equalTo(56)
        }
        let nameLabel = UILabel()
        
        nameLabel.font = UIFont.systemFontOfSize(18)
        nameLabel.textColor = UIColor.whiteColor()
        backImage.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(8)
            make.top.equalTo(headImage)
        }
        let emailLabel = UILabel()
        emailLabel.font = UIFont.systemFontOfSize(15)
        emailLabel.textColor = UIColor.whiteColor()
        backImage.addSubview(emailLabel)
        emailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImage)
        }
        let setButton = UIButton(type: .Custom)
        setButton.setTitle("设置", forState: .Normal)
        setButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        setButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        backImage.addSubview(setButton)
        setButton.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.centerY.equalTo(0)
        }
        nameLabel.text = "大熊猫"
        emailLabel.text = "hehe@qq.com"
        
        let btnArr = ["12\n我的分享","2\n我的下载","1\n我的好友"]
        var lastView:UIButton? = nil
        for btnTitle in btnArr{
            let button = UIButton(type: .Custom)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.titleLabel?.textAlignment = .Center
            button.titleLabel?.numberOfLines = 0
            
            button.jk_setBackgroundColor(UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5 ), forState: .Normal)
            button.setTitle(btnTitle, forState: .Normal)
            backImage.addSubview(button)
            
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lastView == nil ? backImage.snp_left : (lastView?.snp_right)!).offset(lastView == nil ? 0:1)
                make.width.equalTo(backImage).dividedBy(btnArr.count).offset(-1)
//                if lastView != nil{
//                 make.width.equalTo(lastView!)
//                }else{
//                    make.right.equalTo(0)
//                }
                make.height.equalTo(44)
                make.bottom.equalTo(0)
            })
            lastView = button
        }
        
    }
    func configureTitleScroll(){
        //下划线
        //dispalyController.isShowUnderLine = true
        dispalyController.setUpUnderLineEffect { (isShowUnderLine,isDelayScroll, lineHeight, lineColor) in
            isShowUnderLine.memory = true
            lineColor.memory = UIColor.randomColor()
        }
        dispalyController.setUpTitleGradient { (isShowTitleGradient, titleGradientStyle, startR, startG, startB, endR, endG, endB) in
            isShowTitleGradient.memory = true
            titleGradientStyle.memory = YZTitleColorGradientStyleFill
            startR.memory = 0.5
            startG.memory = 0.5
            startB.memory = 0.5
            
            endR.memory = 0.75
            endG.memory = 0.75
            endB.memory = 0.75
        }
    }

    func configureViewControllers(){
        //let dispalyController = YZDisplayViewController.init()
        let picListVC = CSMyPicViewController(nibName: nil, bundle: nil)
        picListVC.title = "图片"
        dispalyController.addChildViewController(picListVC)
        
        let videoListVC = CSMyVideoListViewController.init(nibName: nil, bundle: nil)
        videoListVC.title = "视频"
        videoListVC.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        dispalyController.addChildViewController(videoListVC)
        
        let fileListVC = MyFileListViewController.init(nibName: nil, bundle: nil)
        fileListVC.style = .Plain
        fileListVC.title = "压缩包"
        fileListVC.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        dispalyController.addChildViewController(fileListVC)
        
        //将dispalyVC 加入到本控制器下并展示
        self.addChildViewController(dispalyController)
        self.contentView.addSubview(dispalyController.view)
        
        //配置控制器的大小,让子控制器的view大小可以根据本控制器的view改变而改变
        dispalyController.view.frame = self.view.bounds
       // dispalyController.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        
        dispalyController.view.snp_updateConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(180)
            
        }
        dispalyController.view.backgroundColor = UIColor.whiteColor()
        dispalyController.titleScrollView.backgroundColor = UIColor ( red: 0.849, green: 0.849, blue: 0.849, alpha: 0.66 )
        // 控制器的生命周期
        dispalyController.didMoveToParentViewController(self)
        
      //  self.navigationItem.titleView = dispalyController.titleScrollView
        
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
