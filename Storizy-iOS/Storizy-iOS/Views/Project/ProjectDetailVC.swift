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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "PageCellInProject", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "pageCellInProject")
    }
    
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
            cell.pageTitleLabel.text = "페이지명"
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


