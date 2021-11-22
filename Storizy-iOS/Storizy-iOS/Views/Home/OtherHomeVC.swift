//
//  OtherHomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherHomeVC: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    var feedList: [Any] = [Project(title: "프로젝트명"), Page(title: "페이지명"), Page(title: "페이지명2"), Project(title: "프로젝트명2"), Page(title: "페이지명3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nib 셀 등록
        let projectNibName = UINib(nibName: "ProjectCell", bundle: nil)
        feedTableView.register(projectNibName, forCellReuseIdentifier: "ProjectCell")
        let pageNibName = UINib(nibName: "OtherPageCell", bundle: nil)
        feedTableView.register(pageNibName, forCellReuseIdentifier: "OtherPageCell")

        DispatchQueue.main.async {
            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
        }
        // Do any additional setup after loading the view.
    }
    
    // 닫기
    @IBAction func colseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OtherHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let project = feedList[indexPath.row] as? Project {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
            cell.projectTitleLabel.text = project.title
            cell.projectContentLabel.text = "프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용"
            cell.periodLabel.text = "2020.11.22 - 2021.01.16"
            cell.moreBtn.isHidden = true
            return cell
        }
        
        else if let page = feedList[indexPath.row] as? Page {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherPageCell", for: indexPath) as! OtherPageCell
            cell.pageTitleLabel.text = page.title
            cell.pagePeriodLabel.text = "2020.11.22 - 2021.01.16"
            cell.pageContentLabel.text = "페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let project = feedList[indexPath.row] as? Project {
            let storyboard = UIStoryboard(name: "OtherProjectDetail", bundle: nil)
            let otherProjectDetailVC = storyboard.instantiateViewController(identifier: "OtherProjectDetailVC")
            self.navigationController?.pushViewController(otherProjectDetailVC, animated: true)
        }
        else if let page = feedList[indexPath.row] as? Page {
            let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
            let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
            self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
        }
    }
    
}


