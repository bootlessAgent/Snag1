//
//  SnagCell.swift
//  Snag1
//
//  Created by Eugene Trumpelmann on 2018/10/31.
//  Copyright © 2018 Eugene Trumpelmann. All rights reserved.
//

import UIKit

class SnagCell: UICollectionViewCell {
    
    @IBOutlet weak var snagImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    func displaySnagContentsWith(Image passedImage: UIImage, title:String,detail:String?){
        
        titleLabel.text = title
        detailLabel?.text = detail ?? ""
        snagImage.image = passedImage
        
    }    
}
