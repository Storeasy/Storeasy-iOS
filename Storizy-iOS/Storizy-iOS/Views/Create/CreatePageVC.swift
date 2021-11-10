//
//  CreatePageVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit

class CreatePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료
    @IBAction func completeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


// 이미지 collection view
extension CreatePageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreatePageImgCell", for: indexPath) as! CreatePageImgCell
        // 이미지 등록
        return cell
    }
    
    
}

class CreatePageImgCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

