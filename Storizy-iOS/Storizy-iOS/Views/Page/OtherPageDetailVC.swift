//
//  OtherPageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageDetailVC: UIViewController {

    @IBOutlet weak var nicknameLB: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var pageTitleLB: UILabel!
    @IBOutlet weak var periodLB: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var pageFrameView: UIView!
//    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var tagCVHeight: NSLayoutConstraint!
    @IBOutlet weak var projectBTN: UIButton!
    @IBOutlet weak var heartBTN: UIButton!
    
    
    var pageId: Int = 0
    var pageDetailData: PageDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPageDetail()
        setUI()
        registerNib()
    }
    
    
    func getPageDetail(){
        ReadPageService.shared.readPage(accessToken: accessToken, pageId: pageId) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<PageDetailData>
                print(body)
                self.pageDetailData = body.data
                self.loadPage()
                self.tagCV.reloadData()
                self.setUI()
            } else {
                print(responseCode)
            }
        }
    }
    
    func loadPage(){
        let url = URL(string: pageDetailData?.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png") // 없으면 기본이미지
        let imgData = try! Data(contentsOf: url!)
        profileImgView.image = UIImage(data: imgData)
        nicknameLB.text = pageDetailData?.nickname
        
        pageTitleLB.text = pageDetailData?.title
        periodLB.text = "\(pageDetailData!.startDate!) - \(pageDetailData!.endDate!)"
        heartBTN.imageView?.image = (pageDetailData?.isLiked)! ? UIImage(named: "favorite") : UIImage(named: "favorite_un")
        contentTextView.text = pageDetailData?.content
        if pageDetailData?.projectTitle != nil {
            projectBTN.setTitle("\(pageDetailData?.projectTitle ?? "")에 속해있는 페이지 입니다.", for: .normal)
        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
        let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC")
        self.navigationController?.pushViewController(otherHomeVC, animated: true)
    }
    
    // MARK: - nib 등록
    func registerNib(){
        let storyTagNibName = UINib(nibName: "StoryTagCell", bundle: nil)
        tagCV.register(storyTagNibName, forCellWithReuseIdentifier: "StoryTagCell")
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
        // TV 동적 높이
        DispatchQueue.main.async {
            self.contentTextViewHeight.constant = self.contentTextView.contentSize.height
        }
        
        setShadow(view: headBarView)
        setShadow(view: pageFrameView)
        // 둥글
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
        pageFrameView.layer.cornerRadius = 20
    }
    
}


// 이미지 collection view
extension OtherPageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // tag
        if collectionView == tagCV {
            if pageDetailData?.tags.isEmpty == true {
                tagCVHeight.constant = 0
            }
            return pageDetailData?.tags.count ?? 0
        }
        // img
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // tag
        if collectionView == tagCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as! StoryTagCell
            cell.frameView.backgroundColor = UIColor(named: "white")
            cell.tagNameLB.textColor = UIColor(named: "dark_gray2")
            cell.tagNameLB.text = "#\(pageDetailData?.tags[indexPath.item]?.tagName ?? "")"
            return cell
        }
        // img
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherPageDetailImgCell", for: indexPath) as! OtherPageDetailImgCell
            cell.imageView.layer.cornerRadius = 12
            // 이미지 등록
            return cell
        }
    }
    
    
}

class OtherPageDetailImgCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}
