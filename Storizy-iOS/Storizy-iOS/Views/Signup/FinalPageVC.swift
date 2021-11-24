//
//  FinalPageVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/24.
//

import UIKit

class FinalPageVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var doneBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        // 로그인 화면으로 이동
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - UI
    
    // BTN
    func roundUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
    }
    
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        //round
        roundUI(doneBTN)
    }

}
