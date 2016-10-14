//
//  MyFileListViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/14.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class MyFileListViewController: CSTableViewController {
    var cellModels:[AnyObject] = []
    var cellInfos = [
        [
        "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ],
        [
            "title":"关于JavaScript.doc",
            "imageUrl":"",
            "fileSize":"34.5k",
            "from":"来自大熊猫的分享"
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cellModels = NSArray.yy_modelArrayWithClass(CSMyFileModel.self, json: self.cellInfos)!
        
         //注册Cell
        self.tableView.registerNibOf(CSMyFileCell)
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
extension MyFileListViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CSMyFileCell  = tableView.dequeueReusableCell()
        cell.configureWithModel(cellModels[indexPath.row] as! CSMyFileModel)
        return cell
    }
}