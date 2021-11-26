//
//  HomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

var accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""

class HomeVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // components
    @IBOutlet weak var storyTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    // - 프로필
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var profileFrameView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var univLB: UILabel!
    @IBOutlet weak var contactLB: UILabel!
    @IBOutlet weak var bioLB: UILabel!
    @IBOutlet weak var profileTagCV: UICollectionView!
    
    // - 스토리
    @IBOutlet weak var feedFrameView: UIView!
    @IBOutlet weak var storyTagCV: UICollectionView!
    
    // 실데이터
    var accessToken: String?
    var myProfileData: ProfileData? {
        didSet {
            loadProfile()
        }
    }
    var myStoryTagData: [TagData?] = [] {
        didSet {
            storyTagCV.reloadData()
        }
    }
    
    var myStoryData: [Story?] = [] {
        didSet{
            storyTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        accessToken = UserDefaults.standard.string(forKey: "accessToken")
        // UI 적용
        setViewUI()
        // nib 셀 등록
        registerNib()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 프로필 데이터 불러오기
        getMyProfile()
        getMyStoryTags()
        getMyStory()
    }
    
    // MARK: - 함수
    func registerNib(){
        let profileTagNibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        profileTagCV.register(profileTagNibName, forCellWithReuseIdentifier: "ProfileTagCell")
        
        let storyTagNibName = UINib(nibName: "StoryTagCell", bundle: nil)
        storyTagCV.register(storyTagNibName, forCellWithReuseIdentifier: "StoryTagCell")
        
        let projectNibName = UINib(nibName: "ProjectCell", bundle: nil)
        storyTableView.register(projectNibName, forCellReuseIdentifier: "ProjectCell")
        
        let pageNibName = UINib(nibName: "PageCell", bundle: nil)
        storyTableView.register(pageNibName, forCellReuseIdentifier: "PageCell")
    }
    
    
    // MARK: - 프로필 데이터 뷰에 반영
    
    func loadProfile(){
        // 이미지 URL
        let url = URL(string: myProfileData?.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
        let imgData = try! Data(contentsOf: url!)
        profileImgView.image = UIImage(data: imgData)
        nameLB.text = myProfileData?.nickname ?? "nickname"
        univLB.text = ( myProfileData?.universityName ?? "")
        contactLB.text = myProfileData?.contact ?? "연락처를 추가해주세요"
        bioLB.text = myProfileData?.bio ?? "자기소개를 추가해주세요"
        
        profileTagCV.reloadData()
        storyTagCV.reloadData()
        storyTableView.reloadData()
    }
    
    // MARK: - 서버에서 데이터 불러오기
    
    // 프로필 데이터
    func getMyProfile(){
        MyProfileService.shared.getMyProfile(accessToken: accessToken ?? "") { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<ProfileData> else { return }
                print(body)
                // 프로필에 불러오기
                self.myProfileData = body.data
            } else {
                print(responseCode)
            }
        }
    }
    
    // 스토리 태그 데이터
    func getMyStoryTags(){
        GetMyStoryTagsService.shared.getMyStoryTags(accessToken: accessToken ?? "") { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<[TagData]> else { print("return"); return }
                print(body)
                self.myStoryTagData = body.data ?? []
            } else {
                print(responseCode)
            }
        }
    }
    
    // 스토리 데이터
    func getMyStory(){
        ReadMyStoryService.shared.getMyStory(accessToken: accessToken ?? "") { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<[Story]> else { print("!!!!"); return }
                print("\(body)")
                self.myStoryData = body.data ?? []
            } else {
                print(responseCode)
            }
        }
    }
    
    
    // MARK: - 프로필 편집으로 이동
    
    @IBAction func editProfileAction(_ sender: Any) {
        // 프로필 편집 뷰 이동
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let editProfileVC = storyboard.instantiateViewController(identifier: "EditProfileVC")
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    // MARK: - UI 설정
    
    func setShadow(view: UIView){
        //그림자 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
    }
    
    func setViewUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // 이미지 원
        profileImgView.layer.cornerRadius = profileImgView.bounds.width / 2
        // 둥글
        profileFrameView.layer.cornerRadius = 20
        feedFrameView.layer.cornerRadius = 20
        // 그림자
        setShadow(view: profileFrameView)
        setShadow(view: feedFrameView)
        // 피드 테이블 뷰 높이 동적 조정
//        DispatchQueue.main.async {
//            self.feedTableViewHeight.constant = self.storyTableView.contentSize.height
//        }
    }

    
}

// MARK: - 프로필 태그, 전체 태그 컬렉션 뷰
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case profileTagCV:
            return myProfileData?.tags.count ?? 0
        case storyTagCV:
            return myStoryTagData.count
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
            cell.tagNameLabel.text = myProfileData?.tags[indexPath.item].tagName
            return cell
            
        // 스토리 태그 셀 표현
        case storyTagCV:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as? StoryTagCell else {
                return UICollectionViewCell()
            }
            let cellData = myStoryTagData[indexPath.item]
            cell.selectedColor = cellData?.tagColor
            cell.tagNameLB.text = "#\(cellData?.tagName ?? "")"
            cell.tagNameLB.textColor = UIColor(named: cellData?.tagColor ?? "tag_green")
            cell.frameView.backgroundColor = UIColor(named: "\(cellData?.tagColor ?? "white")-light")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(myStoryTagData[indexPath.item]!.id!)
        // 검색 스토리 조회
        SearchStoryService.shared.getSearchedStory(accessToken: accessToken ?? "", tagId: myStoryTagData[indexPath.item]!.id!) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<[Story]> else { print("!!!!"); return }
                print("\(body)")
                self.myStoryData = body.data ?? []
            } else {
                print(responseCode)
            }
        }
    }
    
    
}


// MARK: - 스토리
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 프로젝트 셀
        if myStoryData[indexPath.row]?.page == nil {
            if let project = myStoryData[indexPath.row]?.project {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell

                // components
                cell.projectTitleLabel.text = project.title
                cell.projectContentLabel.text = project.description
                cell.periodLabel.text = "\(project.startDate!) - \(project.endDate!)"
                cell.tags = project.tags
                cell.dotImage.image = UIImage(named: "\(project.projectColor ?? "tag_green")_project")

                // components ui
                if indexPath.row == 0 {
                    cell.topBar.isHidden = true
                }
                return cell
            }
        }

        
        // 페이지 셀
        else {
            if let page = myStoryData[indexPath.row]?.page {

                let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as! PageCell

                cell.pageTitleLabel.text = page.title
                cell.periodLabel.text = "\(page.startDate!) - \(page.endDate!)"
                cell.pageContentLabel.text = page.content
                cell.tags = page.tags
                cell.dotImage.image = UIImage(named: "tag_black_page")

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
        if myStoryData[indexPath.row]?.page == nil {
            if let project = myStoryData[indexPath.row]?.project {
                // 프로젝트 상세 화면 이동
                let storyboard = UIStoryboard(name: "ProjectDetail", bundle: nil)
                guard let projectDetailVC = storyboard.instantiateViewController(identifier: "ProjectDetailVC") as? ProjectDetailVC else { return }
                projectDetailVC.projectId = project.projectId!
                self.navigationController?.pushViewController(projectDetailVC, animated: true)
            }
        }
        
        // 페이지 셀 선택
        else {
            if let page = myStoryData[indexPath.row]?.page {
                //페이지 상세 화면 이동
                let storyboard = UIStoryboard(name: "PageDetail", bundle: nil)
                guard let pageDetailVC = storyboard.instantiateViewController(identifier: "PageDetailVC") as? PageDetailVC else { return }
                pageDetailVC.pageId = page.pageId!
                self.navigationController?.pushViewController(pageDetailVC, animated: true)
            }
        }
    }
    
    
}
