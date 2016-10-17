
//
//  CSMainPicCell.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/17.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import WPAttributedMarkup
import SDCycleScrollView
import IDMPhotoBrowser
class CSMainPicCell: UITableViewCell {
    var pageLabel = UILabel()
    var imageGroup = ["image01","image02","image03"]
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor ( red: 0.8904, green: 0.8904, blue: 0.8904, alpha: 1.0 )
        //顶部个人信息部分
        let topView = UIView.init()
        topView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(56)
        }
        //头像
        let headImage = UIImageView.init(image: UIImage(named: "首页头像"))
        topView.addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(36)
        }
        //名称
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textColor = UIColor.darkTextColor()
        nameLabel.text = "FateAsuka"
        topView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(headImage.snp_right).offset(8)
            make.top.equalTo(headImage)
        }
        //时间
        let timeLabel = UILabel()
        topView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(headImage)
        }
        //以html的语法来设置label中内容的样式
         //样式表是以字典的形式设置的
         //key 是随意写的，值就是对应的样式，只需要用key 将内容包起来就可以了
        
        let style:[NSString:AnyObject] = ["clock":UIImage(named:"时间图标")!,"fontColor":UIColor.lightGrayColor(),"fontSize":UIFont.systemFontOfSize(13)]
        
        let timeStr :NSString = "<clock> </clock> <fontColor><fontSize>一天</fontColor></fontSize>"
        timeLabel.attributedText = timeStr.attributedStringWithStyleBook(style)
        
        
        //添加好友
        let addFriend = UIButton(type: .Custom)
        addFriend.setImage(UIImage(named:"加好友图标"), forState: .Normal)
        topView.addSubview(addFriend)
        addFriend.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(0)
            make.width.height.equalTo(18)
        }
        //中间的滚动暂时图片视图
         let photoBrowser = SDCycleScrollView()
        //如果是本地的图片
        photoBrowser.localizationImageNamesGroup = ["image01","image02","image03"]
        //本地占位图
        photoBrowser.placeholderImage = UIImage(named:"image01")
        // 不现实PageControl
        photoBrowser.showPageControl = false
        //是否自动滚动
        photoBrowser.autoScroll = false
        //设置代理
        photoBrowser.delegate = self
        self.contentView.addSubview(photoBrowser)
        photoBrowser.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headImage.snp_bottom).offset(8)
            make.height.equalTo(160)
        }
        
        //右上角的页码
        let pageLabel = UILabel()
        pageLabel.textColor = UIColor.whiteColor()
        pageLabel.backgroundColor = UIColor ( red: 0.6667, green: 0.6667, blue: 0.6667, alpha: 0.66 )
        pageLabel.font = UIFont.systemFontOfSize(10)
        //pageLabel.text = "1/3"
        pageLabel.textAlignment = .Center
        pageLabel.layer.cornerRadius = 12
        pageLabel.layer.masksToBounds = true
        
        photoBrowser.addSubview(pageLabel)
        pageLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(8)
            make.width.height.equalTo(24)
        }
        //图片定位
        let locateLabel = UILabel()
        locateLabel.backgroundColor = UIColor ( red: 0.6667, green: 0.6667, blue: 0.6667, alpha: 0.53 )
        
        let locateStyle:[NSString:AnyObject] = ["locate":UIImage(named:"地理图标")!,"font":UIFont.systemFontOfSize(13),"color":UIColor.lightTextColor()]
        let locateStr:NSString = "<locate> </locate><font><color>西安市雁塔区高新四路永安大厦</color></font>"
        locateLabel.attributedText = locateStr.attributedStringWithStyleBook(locateStyle)
        photoBrowser.addSubview(locateLabel)
        locateLabel.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(24)
            
        }
        
        //下面部分
        let tagButton = UIButton(type: .Custom)
        tagButton.setTitle("#我喜欢今天的拍摄", forState: .Normal)
        tagButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        tagButton.jk_setBackgroundColor(UIColor.clearColor(), forState: .Normal)
        tagButton.jk_setBackgroundColor(UIColor.lightGrayColor(), forState: .Highlighted)
        tagButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        tagButton.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        tagButton.layer.cornerRadius = 4
        tagButton.layer.masksToBounds = true
        self.contentView.addSubview(tagButton)
        tagButton.snp_makeConstraints { (make) in
            make.left.equalTo(16)
            //make.right.equalTo(0)
        make.top.equalTo(photoBrowser.snp_bottom).offset(8)
            make.height.equalTo(18)
        }
        
        let titles = ["分享","感兴趣","下载","评论"]
        var lastView:UIButton? = nil
        for title in titles{
            let button = UIButton(type: .Custom)
            button.setImage(UIImage(named: "\(title) 图标"), forState: .Normal)
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.jk_setBackgroundColor(UIColor ( red: 0.6667, green: 0.6667, blue: 0.6667, alpha: 0.54 ), forState: .Normal)
            button.jk_setBackgroundColor(UIColor.whiteColor(), forState: .Highlighted)
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6)
            button.titleLabel?.font = UIFont.systemFontOfSize(13)
            self.contentView.addSubview(button)
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(lastView == nil ? self.contentView.snp_left:(lastView?.snp_right)!)
                make.width.equalTo(self.contentView).dividedBy(4)
                make.height.equalTo(24)
                make.top.equalTo(tagButton.snp_bottom).offset(8)
            })
            lastView = button
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CSMainPicCell:SDCycleScrollViewDelegate{
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didScrollToIndex index: Int) {
        pageLabel.text = "\(index+1)/\(imageGroup.count)"
    }
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        //跳到大图浏览
        var photos = [IDMPhoto]()
        for imageName in imageGroup{
            let image = IDMPhoto.init(image: UIImage(named: imageName))
            photos.append(image)
        }
        let photoBrowser = IDMPhotoBrowser(photos: photos, animatedFromView: cycleScrollView)
        photoBrowser.setInitialPageIndex(UInt(index))
        photoBrowser.displayToolbar = true
        photoBrowser.displayCounterLabel = true
        
        self.jk_viewController.presentViewController(photoBrowser, animated: true, completion: nil)
    }
}