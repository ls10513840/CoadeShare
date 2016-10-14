//
//  CSMypicCell.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/14.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMypicCell: UICollectionViewCell {
    var mask = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "图片"))
        self.contentView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.contentView.addSubview(mask)
        mask.backgroundColor = UIColor ( red: 0.2099, green: 0.2099, blue: 0.2099, alpha: 0.22 )
        mask.alpha = 0
        mask.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
//    override var selected: Bool{
//        didSet{
//            UIView.animateWithDuration(0.25) { 
//                self.mask.alpha = CGFloat(self.selected)
//                
//            }
//        }
//    }
    override var highlighted: Bool{
        didSet{
            UIView.animateWithDuration(0.25) {
                self.mask.alpha = CGFloat(self.highlighted)
                
            }
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
