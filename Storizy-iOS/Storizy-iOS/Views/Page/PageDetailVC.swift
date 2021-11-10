//
//  PageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class PageDetailVC: UIViewController {

    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    // 단독 페이지면 프로젝트명 공란
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // content text view height
        DispatchQueue.main.async {
            self.contentTextViewHeight.constant = self.contentTextView.contentSize.height
        }
        // more btn menu set
        setMoreBtnMenu()
    }
    
    // more btn menu set
    func setMoreBtnMenu(){
        moreBtn.showsMenuAsPrimaryAction = true
        // 수정하기 메뉴 아이템
        let edit = UIAction(title: "수정하기", image: nil) { _ in
            // 수정하기 뷰 띄우기
            let storyboard = UIStoryboard(name: "EditPage", bundle: nil)
            let editPageVC = storyboard.instantiateViewController(identifier: "EditPageVC")
            self.navigationController?.pushViewController(editPageVC, animated: true)
        }
        
        let delete = UIAction(title: "삭제하기", image: nil) { _ in
            // 삭제하기
        }
        
        let cancel = UIAction(title: "취소", attributes: .destructive) { _ in }
        
        moreBtn.menu = UIMenu(title: "project menu", image: nil, identifier: nil, options: .displayInline, children: [edit, delete, cancel])
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// 이미지 collection view
extension PageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageDetailImgCell", for: indexPath) as! PageDetailImgCell
        // 이미지 등록
        return cell
    }
    
    
}

class PageDetailImgCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIView!
    
}
