//
//  OnboardingVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var imgCV: UICollectionView!
    
    let imgsName: [String] = ["info","info","splash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func skipAction(_ sender: Any) {
        let tagSelectVC = self.storyboard?.instantiateViewController(identifier: "TagSelectVC")
        self.navigationController?.pushViewController(tagSelectVC!, animated: true)
        
    }
    
    func setUI(){
        (self.tabBarController as! TabBarController).customTabBarView.isHidden = true
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
    }
}

// MARK: - 컬렉션 뷰
extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guideImgCell", for: indexPath) as? GuideImgCell else { return UICollectionViewCell() }
        cell.imgView.image = UIImage(named: imgsName[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    
}


class GuideImgCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
}
