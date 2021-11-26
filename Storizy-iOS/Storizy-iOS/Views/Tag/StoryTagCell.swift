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
    
    var selectedColor: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                frameView.backgroundColor = UIColor(named: selectedColor ?? "white")
                tagNameLB.textColor = UIColor(named: "extra_white")
            } else {
                frameView.backgroundColor = UIColor(named: "\(selectedColor ?? "tag_green")-light" ?? "white")
                tagNameLB.textColor = UIColor(named: selectedColor ?? "black")
            }
        }
    }
    
    func setUI(){
        frameView.layer.cornerRadius = 15
        frameView.backgroundColor = UIColor(named: "lasing_green")
        tagNameLB.sizeToFit()
    }
}
