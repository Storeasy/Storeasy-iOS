//
//  ProjectDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class ProjectDetailVC: UIViewController {
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectPeriodLabel: UILabel!
    @IBOutlet weak var projectContentTextView: UITextView!
    @IBOutlet weak var pageTableView: UITableView!
    @IBOutlet weak var projectMoreBtn: UIButton!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var projectViewHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "PageCellInProject", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "pageCellInProject")
        
        // 프로젝트 뷰 높이
        DispatchQueue.main.async {
            self.projectViewHeight.constant = 125.5 + self.projectContentTextView.contentSize.height
        }
        
        // more btn menu setting
        moreAction()
    }
    
    func moreAction(){
        projectMoreBtn.showsMenuAsPrimaryAction = true
        // 수정하기 메뉴 아이템
        let edit = UIAction(title: "수정하기", image: nil) { _ in
            // 수정하기 뷰 띄우기
            let storyboard = UIStoryboard(name: "EditProject", bundle: nil)
            let editProjectVC = storyboard.instantiateViewController(identifier: "EditProjectVC")
            self.navigationController?.pushViewController(editProjectVC, animated: true)
        }
        
        let delete = UIAction(title: "삭제하기", image: nil) { _ in
            // 삭제하기
        }
        
        let cancel = UIAction(title: "취소", attributes: .destructive) { _ in }
        
        projectMoreBtn.menu = UIMenu(title: "project menu", image: nil, identifier: nil, options: .displayInline, children: [edit, delete, cancel])
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}



extension ProjectDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pageCellInProject", for: indexPath) as? PageCellInProject {
            cell.pageTitleLabel.text = "페이지명 페이지명"
            cell.pagePeriodLabel.text = "2021.11.22 - 2021.11.23"
            cell.pageContentLabel.text = "페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용"
            return cell
        }
        return UITableViewCell()
    }
    
    // 페이지 셀 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PageDetail", bundle: nil )
        let pageDatailVC = storyboard.instantiateViewController(identifier: "PageDetailVC")
        self.navigationController?.pushViewController(pageDatailVC, animated: true)
    }
    
    
}


