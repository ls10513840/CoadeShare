//
//  CSMyVideoCell.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/13.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMyVideoCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(withModel model:CSMyVideoModel){
        title.text = model.title
        sizeLabel.text = model.videoSize

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
