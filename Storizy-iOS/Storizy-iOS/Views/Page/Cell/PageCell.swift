//
//  PageCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class PageCell: UITableViewCell {

    @IBOutlet weak var pageContentView: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }
    
    func setUI(){
        frameView.layer.cornerRadius = 12
        frameView.layer.borderWidth = 1
        frameView.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            pageContentView.backgroundColor = UIColor(named: "extra_white")
        } else {
            pageContentView.backgroundColor = UIColor(named: "extra_white")
        }
        // Configure the view for the selected state
    }
    
}
