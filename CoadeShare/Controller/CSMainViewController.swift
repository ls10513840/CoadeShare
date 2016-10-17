//
//  CSMianViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/17.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMainViewController: YZDisplayViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewControllers()
    }
    func configureViewControllers(){
        let mainPic = CSMainPicViewController()
        mainPic.style = .Plain
        mainPic.title = "图片"
        mainPic.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainPic)
        
        let mainVideo = CSMainVideoViewController()
        mainVideo.style = .Plain
        mainVideo.title = "视频"
        mainVideo.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainVideo)
        
        let mainFile = CSMainFileViewController()
        mainFile.title = "压缩包"
        mainFile.style = .Plain
        mainFile.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        self.addChildViewController(mainFile)
        
        self.navigationItem.titleView = self.titleScrollView
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
