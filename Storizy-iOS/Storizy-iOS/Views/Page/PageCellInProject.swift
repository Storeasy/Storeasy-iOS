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
    @IBOutlet weak var moreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 더보기 버튼 메뉴 세팅
        setMoreBtnMenu()
    }
    
    // more btn menu set - 
    func setMoreBtnMenu(){
        moreBtn.showsMenuAsPrimaryAction = true
        // 수정하기 메뉴 아이템
        let edit = UIAction(title: "수정하기", image: nil) { _ in
            // 수정하기 뷰 띄우기
            let storyboard = UIStoryboard(name: "EditPage", bundle: nil)
            let editPageVC = storyboard.instantiateViewController(identifier: "EditPageVC")
        }
        
        let delete = UIAction(title: "삭제하기", image: nil) { _ in
            // 삭제하기
        }
        
        let cancel = UIAction(title: "취소", attributes: .destructive) { _ in }
        
        moreBtn.menu = UIMenu(title: "project menu", image: nil, identifier: nil, options: .displayInline, children: [edit, delete, cancel])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
