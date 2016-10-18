//
//  CSMyQRCodeViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import swiftScan
class CSMyQRCodeViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let qrCodeView = UIImageView()
        self.view.addSubview(qrCodeView)
        qrCodeView.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.width.height.equalTo(200)
            // make.top.equalTo(100)
        }
        let qrImage = LBXScanWrapper.createCode("CIQRCodeGenerator", codeString: "https://www.baidu.com", size: CGSizeMake(300, 300), qrColor: UIColor ( red: 0.5279, green: 0.7533, blue: 1.0, alpha: 1.0 ), bkColor: UIColor.whiteColor())
        qrCodeView.image = qrImage
        
        //保存按钮
        let leftSave = UIButton(type: .Custom)
        leftSave.setTitle("截图保存", forState: .Normal)
        self.view.addSubview(leftSave)
        leftSave.jk_setBackgroundColor(UIColor.brownColor(), forState: .Normal)
        leftSave.snp_makeConstraints { (make) in
            make.left.equalTo(100)
            make.top.equalTo(qrCodeView.snp_bottom).offset(24)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        let rightSave = UIButton(type: .Custom)
        rightSave.setTitle("直接保存", forState: .Normal)
        self.view.addSubview(rightSave)
        rightSave.jk_setBackgroundColor(UIColor.purpleColor(), forState: .Normal)
        rightSave.snp_makeConstraints { (make) in
            make.right.equalTo(-60)
            make.top.equalTo(leftSave)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        leftSave.jk_handleControlEvents(.TouchUpInside) { (sender) in
            // 截图
            let screenImage = self.view.jk_screenshot()
            // 保存到相册
            
            UIImageWriteToSavedPhotosAlbum(screenImage, self, Selector("image:"),nil)
        }
    }
    func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:UnsafePointer<Void>){
        if error != nil{
            
        }else{
            
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
