//
//  HeartVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

// page, user 구분 상수
let PAGE: Int = 0
let USER: Int = 1

class HeartVC: UIViewController {
    
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var heartTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var pages: [PageDetailData] = []
    var users: [ProfileData] = []
    var currentDatas: [Any] = [] {
        didSet {
            heartTableView.reloadData()
        }
    }
    
    var type: Int? {
        didSet{
            // type 변경 시
            if type == PAGE {
                currentDatas = pages
            } else {
                currentDatas = users
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPageData()
        getUserData()
        // 페이지가 default
        type = PAGE
        
        registerNib()
        setUI()
    }
    
    // segment 변경시
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
    }
    
    // API
    
    func getUserData(){
        // 사용자 호출
        GetHeartUserService.shared.getHeartUser(accessToken: accessToken) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<[ProfileData]>
                self.users = body.data ?? []
                print(responseCode, responseBody)
            } else {
                print(responseCode, responseBody)
            }
        }
    }
    
    func getPageData(){
        // 페이지 호출
        GetHeartPageService.shared.getHeartPage(accessToken: accessToken) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<[PageDetailData]>
                self.pages = body.data ?? []
                self.currentDatas = self.pages
                print(responseCode, responseBody)
            } else {
                print(responseCode, responseBody)
            }
        }
    }
    
    // MARK: - Nib 등록
    func registerNib(){
        // 셀 등록
        let pageNibName = UINib(nibName: "HeartPageCell", bundle: nil)
        heartTableView.register(pageNibName, forCellReuseIdentifier: "HeartPageCell")
        let userNibName = UINib(nibName: "HeartUserCell", bundle: nil)
        heartTableView.register(userNibName, forCellReuseIdentifier: "HeartUserCell")
    }
    
    // MARK: - UI
    func setShadow(view: UIView){
        //그림자 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
    }
    
    func setUI(){
        // 헤더 그림자
        setShadow(view: headBarView)
    }

}

extension HeartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 페이지
        if type == PAGE {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell", for: indexPath) as! HeartPageCell
            let page = pages[indexPath.row]
            
            let url = URL(string: page.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
            let imgData = try! Data(contentsOf: url!)
            cell.profileImg.image = UIImage(data: imgData)
            
            cell.nicknameLB.text = page.nickname
            cell.pageTitleLB.text = page.title
            cell.pageContentLB.text = page.content
            cell.isLiked = page.isLiked ?? true
            cell.heartBTN.imageView?.image = UIImage(named: "favorite")

            return cell
        }
        
        // 사용자
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartUserCell", for: indexPath) as! HeartUserCell
            let user = users[indexPath.row]
            
            let url = URL(string: user.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
            let imgData = try! Data(contentsOf: url!)
            cell.profileImg.image = UIImage(data: imgData)
            
            cell.usernameLabel.text = user.nickname
            cell.univNameLabel.text = user.universityName
            cell.tags = user.tags
            cell.isLiked = user.isLiked ?? true
            cell.heartBTN.imageView?.image = UIImage(named: "favorite")
            return cell
        }
    }
    
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // 페이지
        if type == PAGE {
            let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
            let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
            self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
        }
        
        // 사용자
        else {
            let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
            guard let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC") as? OtherHomeVC else { return }
            otherHomeVC.userId = users[indexPath.row].userId ?? 0 
            self.navigationController?.pushViewController(otherHomeVC, animated: true)
        }
        
    }
    
}
