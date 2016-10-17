//
//  CSMianVideoViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/17.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import ZFPlayer
class CSMainVideoViewController: CSTableViewController {
    var cellModels:CSVideoListModel!
    var player = ZFPlayerView.sharedPlayerView()
    //存储正在播放的cell
    var playIndex:NSIndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getVideoList()
        // Do any additional setup after loading the view.
        self.tableView.registerNibOf(CSMainVideoCell)
        self.tableView.rowHeight = 267
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
    }
    func getVideoList(){
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            //先取出json文件内容
            let cellData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("videoData.json", ofType: nil)!)
            let cellInfo = try! NSJSONSerialization.JSONObjectWithData(cellData!, options: .MutableContainers)
            self.cellModels = CSVideoListModel.yy_modelWithJSON(cellInfo)
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
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
extension CSMainVideoViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellModels == nil{
            return 0
        }
        return cellModels.videoList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CSMainVideoCell = tableView.dequeueReusableCell()
        //如果当前的cell正在播放
        if indexPath == playIndex{
            // 隐藏播放按钮
            cell.playBtn.hidden = true
        }else{
            cell.playBtn.hidden = false
        }
        cell.startPlay = {()->() in
            //转为tbviewcell里面播放进行设置的衣服方法
            self.player.setVideoURL(NSURL(string:self.cellModels.videoList[indexPath.row].playUrl), withTableView: tableView, atIndexPath: indexPath, withImageViewTag: 100)
            //是否自动播放
            self.player.autoPlayTheVideo()
             //是否有下载功能
            self.player.hasDownload = true
            
            if let temIndex = self.playIndex{
                self.playIndex = indexPath
                //刷新
                 tableView.reloadRowsAtIndexPaths([temIndex], withRowAnimation: .None)
            }
            //存储一下正在播放视频的cell的indexpath
            self.playIndex = indexPath
            //隐藏当前cell的playBtn
            cell.playBtn.hidden = true
            //如果需要刷新一下上个cell的状态
           
        }
        return cell
    }
}