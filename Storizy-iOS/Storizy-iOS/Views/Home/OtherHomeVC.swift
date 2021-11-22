//
//  OtherHomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherHomeVC: UIViewController {
    
    @IBOutlet weak var headBarView: UIView!
    
    @IBOutlet weak var profileFrameView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLB: UILabel!
    @IBOutlet weak var universityNameLB: UILabel!
    @IBOutlet weak var contactLB: UILabel!
    @IBOutlet weak var profileTagCV: UICollectionView!
    @IBOutlet weak var bioLB: UILabel!
    
    @IBOutlet weak var storyFrameView: UIView!
    @IBOutlet weak var storyTagCV: UICollectionView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    var feedList: [Any] = [Project(title: "프로젝트명"), Page(title: "페이지명"), Page(title: "페이지명2"), Project(title: "프로젝트명2"), Page(title: "페이지명3")]
    var storyTags: [String] = ["IT", "개발", "iOS", "안녕하세요태그인데요", "예선진출", "경축", "많관부"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()   // nib 셀 등록
        setUI()         // UI
    }
    
    // 닫기
    @IBAction func colseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Nib 등록
    func registerNib(){
        let profileTagNibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        profileTagCV.register(profileTagNibName, forCellWithReuseIdentifier: "ProfileTagCell")
        
        let storyTagNibName = UINib(nibName: "StoryTagCell", bundle: nil)
        storyTagCV.register(storyTagNibName, forCellWithReuseIdentifier: "StoryTagCell")
        
        let projectNibName = UINib(nibName: "ProjectCell", bundle: nil)
        feedTableView.register(projectNibName, forCellReuseIdentifier: "ProjectCell")
        
        let pageNibName = UINib(nibName: "OtherPageCell", bundle: nil)
        feedTableView.register(pageNibName, forCellReuseIdentifier: "OtherPageCell")
    }
    
    // MARK: - UI
    
    func setShadow(view: UIView){
        //그림자 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
    }
    
    func setUI(){
        // table view 높이
        DispatchQueue.main.async {
            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
        }
        // 이미지 원
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        // 둥글
        profileFrameView.layer.cornerRadius = 20
        storyFrameView.layer.cornerRadius = 20
        // 그림자
        setShadow(view: profileFrameView)
        setShadow(view: storyFrameView)
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
    }
    
}



// MARK: - Table view
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

// MARK: - collection view
extension OtherHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case profileTagCV:
            return 0
//            return myProfileData?.tags.count ?? 0
        case storyTagCV:
            return storyTags.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        // 프로필 태그 셀 표현
        case profileTagCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileTagCell", for: indexPath) as? ProfileTagCell else {
                return UICollectionViewCell()
            }
//            cell.tagNameLabel.text = myProfileData?.tags[indexPath.item].tagName
            return cell
            
        // 스토리 태그 셀 표현
        case storyTagCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as? StoryTagCell else {
                return UICollectionViewCell()
            }
            cell.tagNameLB.text = storyTags[indexPath.item]
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

