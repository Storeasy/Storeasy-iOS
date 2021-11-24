//
//  OtherPageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageDetailVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var pageFrameView: UIView!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var tagCV: UICollectionView!
    
    var tags: [String] = ["예선진출","경축", "스토리지", "빅토리지", "도미토리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerNib()
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
            return tags.count
        }
        // img
        else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // tag
        if collectionView == tagCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as! StoryTagCell
            cell.frameView.backgroundColor = UIColor(named: "tag_green-light")
            cell.tagNameLB.textColor = UIColor(named: "tag_green")
            cell.tagNameLB.text = tags[indexPath.item]
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
