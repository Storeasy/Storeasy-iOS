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
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        

    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
        let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC")
        self.navigationController?.pushViewController(otherHomeVC, animated: true)
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherPageDetailImgCell", for: indexPath) as! OtherPageDetailImgCell
        cell.imageView.layer.cornerRadius = 12
        // 이미지 등록
        return cell
    }
    
    
}

class OtherPageDetailImgCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}
