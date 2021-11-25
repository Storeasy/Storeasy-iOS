//
//  OnboardingFristVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import UIKit

class OnboardingFristVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var skipBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func skipToTagAction(_ sender: Any) {
        let tagSelectVC = self.storyboard?.instantiateViewController(identifier: "TagSelectVC")
        self.navigationController?.pushViewController(tagSelectVC!, animated: true)
    }
    
    @IBAction func nextToGuideAction(_ sender: Any) {
        let guideVC = self.storyboard?.instantiateViewController(identifier: "OnboardingVC")
        self.navigationController?.pushViewController(guideVC!, animated: true)
    }
    
    // MARK: - UI
    // TF, 이전 BNT
    func borderUI<T: UIView>(_ view: T){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }
    
    // TF, BTNs
    func roundUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
    }
    
    func setUI(){
        (self.tabBarController as! TabBarController).customTabBarView.isHidden = true
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // BTN
        roundUI(skipBTN)
        roundUI(nextBTN)
        
    }
}
