//
//  CSMyFileCell.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/14.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit

class CSMyFileCell: UITableViewCell {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    func configureWithModel(model:CSMyFileModel){
        titleLabel.text = model.title
        sizeLabel.text = model.fileSize
        fromLabel.text = model.from
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
