//
//  OtherPageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageDetailVC: UIViewController {

    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var contentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.contentTextViewHeight.constant = self.contentTextView.contentSize.height
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
    
}


// 이미지 collection view
extension OtherPageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherPageDetailImgCell", for: indexPath) as! OtherPageDetailImgCell
        // 이미지 등록
        return cell
    }
    
    
}

class OtherPageDetailImgCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}
