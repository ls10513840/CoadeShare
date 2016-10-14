//
//  CSMyPicViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/14.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMyPicViewController: ViewController {
    var collectionView:UICollectionView!
    var flomLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var cellModels = [
    "图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片","图片"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flomLayout)
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        flomLayout.itemSize = CGSizeMake(60, 60)
        flomLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flomLayout.minimumLineSpacing = 10
        flomLayout.minimumInteritemSpacing = 10
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClassOf(CSMypicCell)
        //self.view.backgroundColor = UIColor.randomColor()
        collectionView.backgroundColor = UIColor.randomColor()
        collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0)
        
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
extension CSMyPicViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CSMypicCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
}