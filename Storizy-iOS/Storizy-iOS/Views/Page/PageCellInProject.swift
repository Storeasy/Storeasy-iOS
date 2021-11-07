//
//  PageCellInProject.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit

class PageCellInProject: UITableViewCell {

    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pagePeriodLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
