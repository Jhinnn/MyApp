//
//  WebsiteCollectionViewCell.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit

class WebsiteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabel.font = SYSTEMFONT(size: 15)
        ViewBorderRadius(view: contentLabel, radius: 2, width: 0.6, color: UIColor.lightGray)
        
    }

}
