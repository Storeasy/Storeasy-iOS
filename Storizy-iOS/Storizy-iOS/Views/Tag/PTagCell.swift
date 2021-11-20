//
//  PTagCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/19.
//

import UIKit

class PTagCell: UICollectionViewCell {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var tagNameLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUI(){
        frameView.layer.cornerRadius = 12
        tagNameLB.sizeToFit()
    }
}
