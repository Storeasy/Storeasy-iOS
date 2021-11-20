//
//  TagCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ProfileTagCell: UICollectionViewCell {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        
    }
    
    func setUI(){
        frameView.layer.cornerRadius = 11
        frameView.layer.borderWidth = 1
        frameView.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
        
        tagNameLabel.sizeToFit()
    }
    
    
}
