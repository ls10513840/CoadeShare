//
//  CSScanViewController.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/18.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import swiftScan
class CSScanViewController: LBXScanViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
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
