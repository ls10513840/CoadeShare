//
//  CSMainVideoCell.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/17.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMainVideoCell: UITableViewCell {
   
    var startPlay:(()->())?
    var isPlaying = false
   
       
    @IBOutlet weak var playBtn: UIButton!
    
  
    @IBAction func player(sender: AnyObject) {
        self.startPlay!()
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
