//
//  CSSettingViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSSettingViewController: CSTableViewController {
    let cellInfos = [
        [
            [
            "title":"个人信息",
                "type":"0"
            ]
        
        ],
        [
            [
                "title":"允许查看我的分享",
                "type":"1"
            ],[
                "title":"允许查看我的下载",
                "type":"1"
            ],[
                "title":"任何人允许添加我为好友",
                "type":"1"
            ],
            
        ],
        [
            [
                "title":"保存到本地",
                "type":"0"
            ],
            [
                "title":"帐号绑定",
                "type":"0"
            ],
            
            
        ],
        [
            [
                "title":"清除缓存",
                "type":"2"
            ],
            [
                "title":"用户反馈",
                "type":"0"
            ],
            [
                "title":"关于",
                "type":"0"
            ],
            
        ],

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor ( red: 0.878, green: 0.878, blue: 0.878, alpha: 1.0 )
        self.tableView.registerClassOf(UITableViewCell)
        self.tableView.rowHeight = 44
        
        self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
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
extension CSSettingViewController{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return self.cellInfos.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellInfos[section].count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell()
        //设置cell的样式,注意复用问题
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.textColor = UIColor.darkTextColor()
        cell.textLabel?.text = self.cellInfos[indexPath.section][indexPath.row]["title"]
        //设置cell右边不同的样式
        let type = self.cellInfos[indexPath.section][indexPath.row]["type"]
        if type == "0"{
            cell.accessoryType = .DisclosureIndicator
        }else if type == "1"{
            cell.accessoryView = UISwitch()
        }else{
            cell.accessoryType = .None
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 0{
            let detailVC = CSMyDetailViewController()
            detailVC.title = "信息详情"
            detailVC.contentInset = contentInset
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}