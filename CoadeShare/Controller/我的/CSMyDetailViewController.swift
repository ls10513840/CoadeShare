//
//  CSMyDetailViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import Alamofire
import swiftScan
class CSMyDetailViewController: CSTableViewController {
    let cellInfos = [
        [
         "title":"昵称",
         "class":"",
        ],
        [
         "title":"性别",
         "class":"",
        ],
        [
         "title":"出生日期",
         "class":"",
        ],
        [
          "title":"所在地",
          "class":"",
        ],
        [
         "title":"扫一扫",
         "class":"",
        ],
        [
        "title":"我的二维码",
        "class":"",
        ],
    ]
    let headerBtn = UIButton(type:.Custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //头视图
        let headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 140))
        //let headerBtn = UIButton(type: .Custom)
        headerBtn.setImage(UIImage(named: "用户头像"), forState: .Normal)
        headerView.addSubview(headerBtn)
        headerBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.width.height.equalTo(110)
        }
        
        self.tableView.tableHeaderView = headerView
        // 上传用户头像
        headerBtn.jk_handleControlEvents(.TouchUpInside) { (sender) in
            UIActionSheet.init(title: "选择头像来源", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选择","拍照").showInView(self.view)
        }
        // 底部视图
        let footerView = UIView(frame:CGRectMake(0, 0, self.view.frame.size.width, 100))
        let footerBtn = UIButton(type: .Custom)
        footerBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        footerBtn.setTitle("退出登录", forState: .Normal)
        footerBtn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        footerBtn.jk_setBackgroundColor(UIColor ( red: 0.9515, green: 0.6179, blue: 0.4722, alpha: 1.0 ), forState: .Normal)
        footerBtn.jk_setBackgroundColor(UIColor.darkGrayColor(), forState: .Highlighted)
        footerView.addSubview(footerBtn)
        footerBtn.snp_makeConstraints { (make) in
            make.center.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(44)
        }
        self.tableView.tableFooterView = footerView
        self.tableView.rowHeight = 44
        self.tableView.backgroundColor = UIColor ( red: 0.9049, green: 0.901, blue: 0.9088, alpha: 1.0 )
        self.tableView.sectionHeaderHeight = 0
        self.tableView.registerClassOf(UITableViewCell)
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
extension CSMyDetailViewController{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.cellInfos.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell()
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.text = self.cellInfos[indexPath.section]["title"]
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //如果点击了扫一扫或者是我的二维码
        if indexPath.section == 4 {
            let scanVC = LBXScanViewController()
            //设置扫码界面的样式
            scanVC.scanStyle?.animationImage = UIImage(named:"美女21")
            scanVC.scanStyle?.colorAngle = UIColor ( red: 0.9543, green: 1.0, blue: 0.4845, alpha: 1.0 )
            scanVC.scanStyle?.photoframeAngleStyle = .Inner
            self.navigationController?.pushViewController(scanVC, animated: true)
            //处理扫描结果
           // scanVC.handleCodeResult(results)
        }else if indexPath.section == 5{
            self.navigationController?.pushViewController(CSMyQRCodeViewController(), animated: true)
        }
    }
}
extension CSMyDetailViewController:UIActionSheetDelegate{
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        guard buttonIndex != 0 else{
            return
        }
        let imagePicker = UIImagePickerController()
        if buttonIndex == 1{
            //从相册选择
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }else if buttonIndex == 2{
            //拍照
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
}
extension CSMyDetailViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //取出编辑后的图片
        let editedImage = info[UIImagePickerControllerEditedImage]
        //压缩图片，转成Data
        let imageData = UIImageJPEGRepresentation(editedImage as! UIImage, 0.9)
        Alamofire.upload(.POST,QFAppBaseURL, multipartFormData: { (formData) in
             formData.appendBodyPart(data: "UserInfo.UpdateAvatar".dataUsingEncoding(NSUTF8StringEncoding)!, name:"service")
           formData.appendBodyPart(data: (CSUserModel.SharedUser.id!.dataUsingEncoding(NSUTF8StringEncoding))!, name:"uid")
            
            formData.appendBodyPart(data: imageData!, name: "avatar", fileName: "\(NSDate.init().timeIntervalSince1970).png)", mimeType: "image/jpeg")
            }) { (encodingResult) in
                switch (encodingResult){
                case .Success(let upload,_,_):
                    upload.responseJSON({ (data, success) in
                        if success{
                            print(data)
                            let dataInfo = data as! NSDictionary
                            self.headerBtn.setImage(editedImage as! UIImage, forState: .Normal)
                            CSUserModel.SharedUser.avatar = "http://10.12.155.20/PhalApi/Public/\(dataInfo["file_url"]!)"
                        }else{
                            print("err\(data)")
                        }
                    })
                case .Failure(let errorType):
                    print(errorType)
                }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}