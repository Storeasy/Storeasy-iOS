//
//  OtherPageCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageCell: UITableViewCell {

    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pagePeriodLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 페이지 좋아요
    @IBAction func likeAction(_ sender: Any) {
    }
    
}
