//
//  SigninVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class SigninVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.setValue("email", forKey: "email")
//        UserDefaults.standard.removeObject(forKey: "email")
//        UserDefaults.standard.key
        
        
    }
    
    // MARK: - 뒤로가기 버튼 클릭
    // 스플래시 화면으로 이동
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 로그인 시도
    @IBAction func signinAction(_ sender: Any) {
        //서버로 로그인 요청 전송
        //에러 처리 (alert로)
        
        //성공시 탭바C으로 이동
        let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarController = tabBarStoryboard.instantiateViewController(identifier: "TabBarController")
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
    }
    
}
