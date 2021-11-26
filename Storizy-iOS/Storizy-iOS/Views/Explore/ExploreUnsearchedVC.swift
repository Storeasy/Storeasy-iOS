//
//  ExploreUnsearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreUnsearchedVC: UIViewController {
    
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentCV: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let contentImageNames: [String] = ["content1", "content2"]
    let contentPageIds: [Int] = [19,20]
    
    var recommPages: [PageDetailData] = [] {
        didSet{
            tableView.reloadData()
            setUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecomPages()
        registerNib()   // nib 등록
        setUI()         // UI
        
    }
    
    // 추천 페이지 목록 조회
    func getRecomPages(){
        GetRecomPageService.shared.getRecomPages(accessToken: accessToken) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<[PageDetailData]>
                self.recommPages = body.data ?? []
            } else {
                print(responseCode)
            }
        }
    }
    
    
    // 검색 바 클릭
    @IBAction func searchBarBtnAction(_ sender: Any) {
        let exploreSearchedVC = self.storyboard?.instantiateViewController(identifier: "ExploreSearchedVC") as! ExploreSearchedVC
        self.navigationController?.pushViewController(exploreSearchedVC, animated: false)
    }
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "HeartPageCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HeartPageCell")
    }
    
    // ui
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        // 서치바
        searchBar.layer.borderWidth = 0
        
        // table view - scroll view
//        DispatchQueue.main.async {
//            self.tableViewHeight.constant = self.tableView.contentSize.height
//        }
    }

}


extension ExploreUnsearchedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell") as? HeartPageCell else { return UITableViewCell() }
        let page = recommPages[indexPath.row]
        print("page\(page)")
        let url = URL(string: page.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
        let imgData = try! Data(contentsOf: url!)
        cell.profileImg.image = UIImage(data: imgData)
        
        //하트
        cell.nicknameLB.text = page.nickname
        cell.pageTitleLB.text = page.title
        cell.pageContentLB.text = page.content
        return cell
    }
    
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        guard let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC") as? OtherPageDetailVC else { return }
        otherPageDetailVC.pageId = recommPages[indexPath.row].pageId ?? 0
        self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
    }
}

// 콘텐츠 CV
extension ExploreUnsearchedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentPageIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as? ContentCell else { return UICollectionViewCell() }
        cell.imgView.image = UIImage(named: contentImageNames[indexPath.item])
        cell.layer.cornerRadius = 20
        return cell
    }
    
    // 선택
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //페이지 상세 화면 이동
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        guard let pageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC") as? OtherPageDetailVC else { return }
        pageDetailVC.pageId = contentPageIds[indexPath.item]
        self.navigationController?.pushViewController(pageDetailVC, animated: true)
    }
    
}

// 콘텐츠 이미지 셀
class ContentCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
}
