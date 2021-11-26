//
//  ExploreSearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreSearchedVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pages: [PageDetailData] = []
    var users: [ProfileData] = []
    var currentDatas: [Any] = []
    {
        didSet{
            tableView.reloadData()
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
        type = PAGE         // 페이지가 default
        registerNib()
        setUI()
    }
    
    // nib 등록
    func registerNib(){
        // 셀 등록
        let pageNibName = UINib(nibName: "HeartPageCell", bundle: nil)
        tableView.register(pageNibName, forCellReuseIdentifier: "HeartPageCell")
        let userNibName = UINib(nibName: "HeartUserCell", bundle: nil)
        tableView.register(userNibName, forCellReuseIdentifier: "HeartUserCell")
    }
    
    // type 변경
    @IBAction func segmentedDidChange(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
    }
    
    // ui
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
    }
    
}

extension ExploreSearchedVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let searchTagName = searchBar.text ?? ""
        // 페이지 호출
        SearchPageByTagService.shared.searchPageByTag(accessToken: accessToken, tagName: searchTagName) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<[PageDetailData]>
                self.pages = body.data ?? []
                self.currentDatas = self.pages
                print(responseCode, responseBody)
            } else {
                print(responseCode, responseBody)
            }
        }
        // 사용자 호출
        SearchProfileByTagService.shared.searchProfileByTag(accessToken: accessToken, tagName: searchTagName) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<[ProfileData]>
                self.users = body.data ?? []
                print(responseCode, responseBody)
            } else {
                print(responseCode, responseBody)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
}

extension ExploreSearchedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("currentDatas\(currentDatas)")
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
            
            //하트
            cell.heartBTN.imageView?.image = UIImage(named: "favorite_un")
            cell.nicknameLB.text = page.nickname
            cell.pageTitleLB.text = page.title
            cell.pageContentLB.text = page.content
            return cell
        }
        
        // 사용자
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartUserCell", for: indexPath) as! HeartUserCell
            
            let profile = users[indexPath.row]
            
            let url = URL(string: profile.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
            let imgData = try! Data(contentsOf: url!)
            cell.profileImg.image = UIImage(data: imgData)
    
            cell.heartBTN.imageView?.image = UIImage(named: "favorite_un")
            cell.usernameLabel.text = profile.nickname
            cell.univNameLabel.text = profile.universityName
            cell.tags = profile.tags
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // 페이지
        if type == PAGE {
            let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
            guard let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC") as? OtherPageDetailVC else { return }
            otherPageDetailVC.pageId = pages[indexPath.row].pageId ?? 0
            self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
        }
        
        // 사용자
        else {
            let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
            guard let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC") as? OtherHomeVC else { return }
            print(users[indexPath.row].userId)
            otherHomeVC.userId = users[indexPath.row].userId ?? 0
            self.navigationController?.pushViewController(otherHomeVC, animated: true)
        }
    }
    
    
}
