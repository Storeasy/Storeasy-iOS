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
    
    var userId: Int = 0
    var profileData: ProfileData? {
        didSet {
            loadProfile()
        }
    }
    var storyTagData: [TagData?] = [] {
        didSet {
            storyTagCV.reloadData()
        }
    }
    
    var storyData: [Story?] = [] {
        didSet{
            feedTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()   // nib 셀 등록
        setUI()         // UI
        // 프로필, 태그, 스토리 불러오기
        getProfile()
        getStoryTags()
        getStory()
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
    
    // MARK: - 프로필 데이터 뷰에 반영

    func loadProfile(){
        // 이미지 URL
        let url = URL(string: profileData?.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
        let imgData = try! Data(contentsOf: url!)
        profileImageView.image = UIImage(data: imgData)
        nicknameLB.text = profileData?.nickname ?? "nickname"
        universityNameLB.text = ( profileData?.universityName ?? "")
        contactLB.text = profileData?.contact ?? "연락처를 추가해주세요"
        bioLB.text = profileData?.bio ?? "자기소개를 추가해주세요"
        
        profileTagCV.reloadData()
    }
    
    // MARK: - 서버에서 데이터 불러오기
    
    // 프로필 데이터
    func getProfile(){
        ProfileService.shared.getProfile(accessToken: accessToken ?? "", userId: userId) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<ProfileData> else { return }
                print(body)
                // 프로필에 불러오기
                self.profileData = body.data
                self.loadProfile()
            } else {
                print(responseCode)
            }
        }
    }
    
    
    // 스토리 태그 데이터
    func getStoryTags(){
        GetStoryTagsService.shared.getStoryTags(accessToken: accessToken ?? "", userId: userId) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<[TagData]> else { print("return"); return }
                print(body)
                self.storyTagData = body.data ?? []
                self.storyTagCV.reloadData()
            } else {
                print(responseCode)
            }
        }
    }
    
    // 스토리 데이터
    func getStory(){
        GetStoryService.shared.getStory(accessToken: accessToken ?? "", userId: userId) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<[Story]> else { print("!!!!"); return }
                self.storyData = body.data ?? []
                self.feedTableView.reloadData()
            } else {
                print(responseCode)
            }
        }
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
//        DispatchQueue.main.async {
//            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
//        }
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



// MARK: - 스토리
extension OtherHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 프로젝트 셀
        if storyData[indexPath.row]?.page == nil {
            if let project = storyData[indexPath.row]?.project {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell

                // components
                cell.projectTitleLabel.text = project.title
                cell.projectContentLabel.text = project.description
                cell.periodLabel.text = "\(project.startDate!) - \(project.endDate!)"
                cell.tags = project.tags
                cell.dotImage.image = UIImage(named: "tag_black_project")

                // components ui
                if indexPath.row == 0 {
                    cell.topBar.isHidden = true
                }
                return cell
            }
        }

        
        // 페이지 셀
        else {
            if let page = storyData[indexPath.row]?.page {

                let cell = tableView.dequeueReusableCell(withIdentifier: "OtherPageCell", for: indexPath) as! OtherPageCell

                cell.pageTitleLabel.text = page.title
                cell.pagePeriodLabel.text = "\(page.startDate!) - \(page.endDate!)"
                cell.pageContentLabel.text = page.content
                cell.tags = page.tags
                cell.dotImg.image = UIImage(named: "tag_black_page")

                // components ui
                if indexPath.row == 0 {
                    cell.topBar.isHidden = true
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 프로젝트 셀 선택
        if storyData[indexPath.row]?.page == nil {
            if let project = storyData[indexPath.row]?.project {
                // 프로젝트 상세 화면 이동
                let storyboard = UIStoryboard(name: "ProjectDetail", bundle: nil)
                guard let projectDetailVC = storyboard.instantiateViewController(identifier: "ProjectDetailVC") as? ProjectDetailVC else { return }
                projectDetailVC.projectId = project.projectId!
                self.navigationController?.pushViewController(projectDetailVC, animated: true)
            }
        }
        
        // 페이지 셀 선택
        else {
            if let page = storyData[indexPath.row]?.page {
                //페이지 상세 화면 이동
                let storyboard = UIStoryboard(name: "PageDetail", bundle: nil)
                guard let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC") as? OtherPageDetailVC else { return }
                otherPageDetailVC.pageId = page.pageId!
                self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
            }
        }
    }
    
    
}


// MARK: - collection view
extension OtherHomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case profileTagCV:
            return profileData?.tags.count ?? 0
        case storyTagCV:
            return storyTagData.count
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
            cell.tagNameLabel.text = profileData?.tags[indexPath.item].tagName
            return cell
            
        // 스토리 태그 셀 표현
        case storyTagCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as? StoryTagCell else {
                return UICollectionViewCell()
            }
            let cellData = storyTagData[indexPath.item]
            cell.selectedColor = cellData?.tagColor
            cell.tagNameLB.text = "#\(cellData?.tagName ?? "")"
            cell.tagNameLB.textColor = UIColor(named: "dark_dray1")
            cell.frameView.backgroundColor = UIColor(named: "white")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

