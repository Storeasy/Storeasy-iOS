//
//  StoryTagCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/19.
//

import UIKit

class StoryTagCell: UICollectionViewCell {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var tagNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    func setUI(){
        frameView.layer.cornerRadius = 15
        frameView.backgroundColor = UIColor(named: "lasing_green")
        tagNameLB.sizeToFit()
    }
}
