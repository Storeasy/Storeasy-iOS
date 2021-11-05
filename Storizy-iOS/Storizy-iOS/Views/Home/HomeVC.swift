//
//  HomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //최초시작
        if UserDefaults.standard.string(forKey: "firstLoad") == nil {
            print("최초시작")
            UserDefaults.standard.setValue("false", forKey: "firstLoad")
            // 온보딩
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(identifier: "OnboardingVC") as! OnboardingVC
            onboardingVC.modalPresentationStyle = .popover
            present(onboardingVC, animated: true, completion: nil)
        }
        //!최초시작
        else {
            print("!최초시작")
            UserDefaults.standard.removeObject(forKey: "firstLoad")
            //홉 화면 띄우기
        }
        
    }
    
}
