//
//  HomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    // feedList 더미 데이터
    var feedList: [Any] = [Project(title: "프로젝트명"), Page(title: "페이지명"), Page(title: "페이지명2"), Project(title: "프로젝트명2"), Page(title: "페이지명3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nib 셀 등록
        let projectNibName = UINib(nibName: "ProjectCell", bundle: nil)
        feedTableView.register(projectNibName, forCellReuseIdentifier: "projectCell")
        let pageNibName = UINib(nibName: "PageCell", bundle: nil)
        feedTableView.register(pageNibName, forCellReuseIdentifier: "pageCell")

        // 피드 테이블 뷰 높이 동적 조정
        DispatchQueue.main.async {
            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
        }

        // 최초시작
        if UserDefaults.standard.string(forKey: "firstLoad") == nil {
            print("최초시작")
            UserDefaults.standard.setValue("false", forKey: "firstLoad")
            // 온보딩
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(identifier: "OnboardingVC") as! OnboardingVC
            onboardingVC.modalPresentationStyle = .popover
            present(onboardingVC, animated: true, completion: nil)
        }
        
        // !최초시작
        
        
    }
    
    // 프로필 편집
    @IBAction func editProfileAction(_ sender: Any) {
        // 프로필 편집 뷰 이동
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(identifier: "EditProfileVC")
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
}

// 피드 테이블 뷰
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 프로젝트 셀
        if let project = feedList[indexPath.row] as? Project  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCell
            cell.projectTitleLabel.text = project.title
            cell.projectContentLabel.text = "프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용"
            cell.periodLabel.text = "2020.11.22 - 2021.01.16"
            return cell
            
        }
        // 페이지 셀
        else if let page = feedList[indexPath.row] as? Page {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pageCell", for: indexPath) as! PageCell
            cell.pageTitleLabel.text = page.title
            cell.periodLabel.text = "2020.11.22 - 2021.01.16"
            cell.pageContentLabel.text = "페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 프로젝트 셀 선택
        if let project = feedList[indexPath.row] as? Project {
            // 프로젝트 상세 화면 이동
            let storyboard = UIStoryboard(name: "ProjectDetail", bundle: nil)
            let projectDetailVC = storyboard.instantiateViewController(identifier: "ProjectDetailVC")
            self.navigationController?.pushViewController(projectDetailVC, animated: true)
        }
        // 페이지 셀 선택
        else if let page = feedList[indexPath.row] as? Page {
            //페이지 상세 화면 이동
            let storyboard = UIStoryboard(name: "PageDetail", bundle: nil)
            let pageDetailVC = storyboard.instantiateViewController(identifier: "PageDetailVC")
            self.navigationController?.pushViewController(pageDetailVC, animated: true)
        }
    }
    
}
