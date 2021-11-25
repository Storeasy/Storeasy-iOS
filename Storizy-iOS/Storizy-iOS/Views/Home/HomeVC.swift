//
//  HomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class HomeVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // components
    @IBOutlet weak var feedTableView: UITableView!
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
    
    // 더미
    var feedList: [Any] = [Project(title: "프로젝트명"), Page(title: "페이지명"), Page(title: "페이지명2"), Project(title: "프로젝트명2"), Page(title: "페이지명3")]
    var storyTags: [String] = ["IT", "개발", "iOS", "안녕하세요태그인데요", "예선진출", "경축", "많관부"]

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        
        
        
        // 온보딩 TEST
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let onboardingFristVC = storyboard.instantiateViewController(identifier: "OnboardingFristVC") as! OnboardingFristVC
        self.navigationController?.pushViewController(onboardingFristVC, animated: true)
        
        
        
        
        // 최초시작
        if UserDefaults.standard.string(forKey: "firstLoad") == nil {
            print("최초시작")
            UserDefaults.standard.setValue("false", forKey: "firstLoad")
            // 온보딩
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingFristVC = storyboard.instantiateViewController(identifier: "OnboardingFristVC") as! OnboardingFristVC
            self.navigationController?.pushViewController(onboardingFristVC, animated: true)
        }
//        UserDefaults.standard.removeObject(forKey: "firstLoad")

        
        // !최초시작
        
        // UI 적용
        setViewUI()
        
        // nib 셀 등록
        registerNib()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 프로필 데이터 불러오기
        getMyProfile()
    }
    
    // MARK: - 함수
    func registerNib(){
        let profileTagNibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        profileTagCV.register(profileTagNibName, forCellWithReuseIdentifier: "ProfileTagCell")
        
        let storyTagNibName = UINib(nibName: "StoryTagCell", bundle: nil)
        storyTagCV.register(storyTagNibName, forCellWithReuseIdentifier: "StoryTagCell")
        
        let projectNibName = UINib(nibName: "ProjectCell", bundle: nil)
        feedTableView.register(projectNibName, forCellReuseIdentifier: "ProjectCell")
        
        let pageNibName = UINib(nibName: "PageCell", bundle: nil)
        feedTableView.register(pageNibName, forCellReuseIdentifier: "PageCell")
    }
    
    
    // MARK: - 프로필 데이터 뷰에 반영
    
    func loadProfile(){
        // 이미지 URL
//        let url = URL(string: "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png")
        let url = URL(string: myProfileData?.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
        let imgData = try! Data(contentsOf: url!)
        profileImgView.image = UIImage(data: imgData)
        nameLB.text = myProfileData?.nickname ?? "nickname"
        univLB.text = ( myProfileData?.universityName ?? "")
        contactLB.text = myProfileData?.contact ?? "연락처를 추가해주세요"
        bioLB.text = myProfileData?.bio ?? "자기소개를 추가해주세요"
        
        profileTagCV.reloadData()
        storyTagCV.reloadData()
        feedTableView.reloadData()
    }
    
    // MARK: - 서버에서 프로필 데이터 불러오기
    
    func getMyProfile(){
        // access token 전송
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else { return }
        accessToken = token
        MyProfileService.shared.getMyProfile(accessToken: self.accessToken!) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ResponseData<ProfileData> else { return }
                print(body)

                // 프로필에 불러오기
                self.myProfileData = body.data

            } else {
                UserDefaults.standard.removeObject(forKey: "accessToken")
                self.appDelegate.switchRootSignin()
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
        DispatchQueue.main.async {
            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
        }
    }

    
}

// MARK: - 프로필 태그, 전체 태그, 프로젝트 컬렉션 뷰
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case profileTagCV:
            return myProfileData?.tags.count ?? 0
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
            cell.tagNameLabel.text = myProfileData?.tags[indexPath.item].tagName
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

// MARK: - 피드 테이블 뷰
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedList.count;
    }
    
    // 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 프로젝트 셀
        if let project = feedList[indexPath.row] as? Project  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
            
            // components
            cell.projectTitleLabel.text = project.title
            cell.projectContentLabel.text = "프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용 프로젝트 내용"
            cell.periodLabel.text = "2020.11.22 - 2021.01.16"
            cell.tags = storyTags
            
            // components ui
            if indexPath.row == 0 {
                cell.topBar.isHidden = true
            } else if indexPath.row == feedList.count - 1 {
                cell.bottomBar.isHidden = true
            }
            return cell
            
        }
        
        // 페이지 셀
        else if let page = feedList[indexPath.row] as? Page {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as! PageCell
            
            cell.pageTitleLabel.text = page.title
            cell.periodLabel.text = "2020.11.22 - 2021.01.16"
            cell.pageContentLabel.text = "페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용 페이지 내용"
            cell.tags = storyTags
            
            // components ui
            if indexPath.row == 0 {
                cell.topBar.isHidden = true
            } else if indexPath.row == feedList.count - 1 {
                cell.bottomBar.isHidden = true
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // 셀 선택 시
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
