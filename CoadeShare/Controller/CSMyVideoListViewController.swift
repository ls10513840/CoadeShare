//
//  CSMyVideoListViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/13.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMyVideoListViewController: CSTableViewController {
    var cellInfos:[[String:AnyObject]] = []
    var cellModels:[AnyObject] = []
    var segmetCtrl:UISegmentedControl?
    var index:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        //配置数据
        self.tableView.registerNib(UINib.init(nibName: String(CSMyVideoCell), bundle: nil), forCellReuseIdentifier: String(CSMyVideoCell))
        self.getData()
        //creatsegment()
        creatTbHeadView()
    }
    func creatTbHeadView(){
        let view = UIView()
        let imageView = UIImageView(image: UIImage(named: "背景图片"))
        view.frame = CGRectMake(0, 0, 414, 200)
        tableView.tableHeaderView = view
        view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(160)
            make.top.equalTo(0)
        }
        
        let itemName = ["图片","视频","压缩包"]
        segmetCtrl = UISegmentedControl(items: itemName)
        segmetCtrl?.layer.borderColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5 ).CGColor
        segmetCtrl?.layer.borderWidth = 1
        segmetCtrl?.backgroundColor = UIColor.clearColor()
        segmetCtrl?.tintColor = UIColor.clearColor()
        segmetCtrl?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blackColor()], forState: .Normal)
        segmetCtrl?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor ( red: 0.502, green: 1.0, blue: 0.0, alpha: 1.0 )], forState: .Selected)
        view.addSubview(segmetCtrl!)
        segmetCtrl?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(40)
            make.bottom.equalTo(0)
        })
        segmetCtrl?.jk_handleControlEvents(UIControlEvents.ValueChanged, withBlock: { (sender) in
            self.index = (self.segmetCtrl?.selectedSegmentIndex)!
            if self.index == 0{
                //tableView.style = .Plain
            }else if self.index == 1{
                self.tableView.visibleCells[self.index]
            }else if self.index == 2{
                
            }
        })
    }
    
    func getData(){
        cellInfos = [["title":"杭州铁笼沉尸案主犯获死刑","imageUrl":"视频","videoUrl":"http://www.baidu.com"],["title":"河南政府吃饭打白条欠120万，字数不够还得凑","imageUrl":"视频","videoUrl":"http://www.baidu.com"],["title":"河南政府吃饭打白条欠120万，字数不够还得凑","imageUrl":"视频","videoUrl":"http://www.baidu.com"],["title":"河南政府吃饭打白条欠120万，字数不够还得凑","imageUrl":"视频","videoUrl":"http://www.baidu.com"]]
        
        cellModels = NSArray.yy_modelArrayWithClass(CSMyVideoModel.self, json: cellInfos)!
        self.tableView.reloadData()
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
extension CSMyVideoListViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier(String(CSMyVideoCell)) as! CSMyVideoCell
        cell.configure(withModel: cellModels[indexPath.row] as! CSMyVideoModel)
        return cell
    }
}