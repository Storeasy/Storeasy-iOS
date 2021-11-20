//
//  PageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class PageDetailVC: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var frameViewHeight: NSLayoutConstraint!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var tagCV: UICollectionView!
    
    // data
    var tags: [String] = ["러시아워","유기현최고"]
    
    // 단독 페이지면 프로젝트명 공란
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view height
        DispatchQueue.main.async {
            self.frameViewHeight.constant = 314 + self.contentTextView.contentSize.height
        }
        // more btn menu set
        setMoreBtnMenu()
        
        //ui
        setUI()
        
        //tag cell 등록
        registerNib()
    }
    
    // MARK: - more btn menu set
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
    
    // MARK: - 함수
    
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
        setShadow(view: topBarView)
        setShadow(view: frameView)
        // 둥글
        frameView.layer.cornerRadius = 20
    }
    
}

// MARK: - 이미지, 태그 collection view
extension PageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case tagCV:
            return tags.count
        case imgCollectionView:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case tagCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryTagCell", for: indexPath) as! StoryTagCell
            cell.frameView.backgroundColor = UIColor(named: "white")
            cell.tagNameLB.textColor = UIColor(named: "main")
            cell.tagNameLB.text = tags[indexPath.item]
            return cell
        case imgCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageDetailImgCell", for: indexPath) as! PageDetailImgCell
            cell.imgView.layer.cornerRadius = 12
            // 이미지 등록
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
}

class PageDetailImgCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIView!
}
