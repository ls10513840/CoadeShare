
//
//  CSSharePhotoViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import UzysAssetsPickerController
import IDMPhotoBrowser
class CSSharePhotoViewController: CSscrollerViewController {
    var cellModels = [UIImage(named:"加好友图标")]
    var photoList:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let shareBtn = UIButton(type: .Custom)
        shareBtn.setTitle("分享", forState: .Normal)
        shareBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        shareBtn.jk_setBackgroundColor(UIColor ( red: 0.7555, green: 1.0, blue: 0.434, alpha: 1.0 ), forState: .Normal)
        shareBtn.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        shareBtn.layer.cornerRadius = 4
        shareBtn.layer.masksToBounds = true
        shareBtn.frame = CGRectMake(0, 0, 56, 24)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareBtn)
        //文本框
        let textView = UITextView()
        textView.font = UIFont.systemFontOfSize(15)
        self
        .contentView.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.centerX.equalTo(0)
            make.height.equalTo(100)
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake((self.view.width - 30)/4, (self.view.width - 30)/4)
        flowLayout.minimumLineSpacing = 6
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6)
         photoList = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.contentView.addSubview(photoList)
        photoList.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(textView.snp_bottom)
        }
        photoList.backgroundColor = UIColor ( red: 0.9356, green: 0.9356, blue: 0.9356, alpha: 1.0 )
        photoList.registerClassOf(CSMypicCell)
        photoList.delegate = self
        photoList.dataSource = self
        self.scrollView.backgroundColor = UIColor ( red: 0.9356, green: 0.9356, blue: 0.9356, alpha: 1.0 )
        self.contentView.backgroundColor = UIColor.clearColor()
        
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
extension CSSharePhotoViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellModels.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CSMypicCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.imageView.image = self.cellModels[indexPath.item]
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == self.cellModels.count - 1{
            //如果点击的是加号
            let pickerVC = UzysAssetsPickerController()
            //设置最多可以选择几个图片
              pickerVC.maximumNumberOfSelectionPhoto = 9
            //设置选择视频的个数
            pickerVC.maximumNumberOfSelectionVideo = 3
            
            //设置样式和代理
            UzysAppearanceConfig.sharedConfig().finishSelectionButtonColor = UIColor ( red: 0.1637, green: 0.6541, blue: 1.0, alpha: 1.0 )
            pickerVC.delegate = self
            self.presentViewController(pickerVC, animated: true, completion: nil)
            
        }else{
         // 如果点击的是图片，浏览图片
            
            //设置图片数组
            var photoGroup:[IDMPhoto] = []
            for image in self.cellModels{
                if image == self.cellModels.last! {
                    break
                }
                let photo = IDMPhoto(image: image!)
                photoGroup.append(photo)
            }
            let photoBrowser = IDMPhotoBrowser.init(photos: photoGroup, animatedFromView: collectionView.cellForItemAtIndexPath(indexPath))
            photoBrowser.setInitialPageIndex(UInt(indexPath.item))
            self.presentViewController(photoBrowser, animated: true, completion: nil)
        }
    }
}
extension CSSharePhotoViewController:UzysAssetsPickerControllerDelegate{
    func uzysAssetsPickerControllerDidCancel(picker: UzysAssetsPickerController!) {
        //点击取消
    }
    func uzysAssetsPickerController(picker: UzysAssetsPickerController!, didFinishPickingAssets assets: [AnyObject]!) {
        //成功选中了某些图片
        for asSet in assets{
            let representation = asSet as! ALAsset
            if let photoType = representation.valueForProperty(ALAssetPropertyType){
                let fullImage =  representation.defaultRepresentation().fullResolutionImage().takeUnretainedValue()
                let selectImage = UIImage.init(CGImage: fullImage)
                
                self.cellModels
                .insert(selectImage, atIndex: 0)
            }
        }
        //刷新
        self.photoList.reloadData()
    }
    func uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection(picker: UzysAssetsPickerController!) {
        //超出选择的个数
    }
}