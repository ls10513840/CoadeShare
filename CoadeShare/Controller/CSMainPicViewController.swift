

//
//  CSMainPicViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/17.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMainPicViewController: CSTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClassOf(CSMainPicCell)
        //如果所有的cell高度一样，就尽量去赋值这个属性，如果高度不一样，那么需要重写代理方法，可以限制提高tbview的性能
        self.tableView.rowHeight = 280
        self.tableView.allowsSelection = false
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
extension CSMainPicViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CSMainPicCell = tableView.dequeueReusableCell()
        
        
        return cell
    }
}