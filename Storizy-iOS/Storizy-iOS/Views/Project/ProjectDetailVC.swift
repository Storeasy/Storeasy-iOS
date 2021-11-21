//
//  ProjectDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class ProjectDetailVC: UIViewController {
    // components
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectPeriodLabel: UILabel!
    @IBOutlet weak var projectContentTextView: UITextView!
    @IBOutlet weak var pageTableView: UITableView!
    @IBOutlet weak var projectMoreBtn: UIButton!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var projectInsideFrameHeight: NSLayoutConstraint!
    
    @IBOutlet weak var projectInsideFrameView: UIView!
    
    var storyTags: [String] = ["IT", "개발", "iOS", "안녕하세요태그인데요", "몬스타엑스", "러시아워", "많관부"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()   // nib 등록
        moreAction()    // more btn menu setting
        setUI()         // UI
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
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "PageCell", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "PageCell")
    }
    
    
    // MARK: - UI
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        // 프로젝트 뷰 둥글
        projectInsideFrameView.layer.cornerRadius = 12
        
        // 프로젝트 뷰 높이
        DispatchQueue.main.async {
            self.projectInsideFrameHeight.constant = 106 + self.projectContentTextView.contentSize.height
        }
    }
    
}


// MARK: - table view
extension ProjectDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as? PageCell {
            cell.pageTitleLabel.text = "페이지명 페이지명"
            cell.periodLabel.text = "2021.11.22 - 2021.11.23"
            cell.pageContentLabel.text = "페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용"
            cell.tags = storyTags
            // components ui
            if indexPath.row == 1 {
                cell.bottomBar.isHidden = true
            }
            
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


