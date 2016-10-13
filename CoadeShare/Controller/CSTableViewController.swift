//
//  CSTableViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/13.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSTableViewController: ViewController {
    var style:UITableViewStyle = .Grouped
    
     init (whitStyle style:UITableViewStyle){
        super.init(nibName: nil, bundle: nil)
        self.style = style
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private(set) lazy var tableView:UITableView = {
       let style = self.style
        let tableView = UITableView(frame: CGRectZero, style: style)
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor ( red: 1.0, green: 0.951, blue: 0.9894, alpha: 1.0 )
        tableView.rowHeight = 64
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var contentInset = UIEdgeInsetsZero{
        didSet{
            tableView.contentInset = contentInset
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        contentInset = UIEdgeInsetsMake(topBarHeight, 0, tabBarHeight, 0)
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
extension CSTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}