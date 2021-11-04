//
//  SplashViewController.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Signin", bundle: nil)
        if let signinVC = self.storyboard?.instantiateViewController(identifier: "SigninVC") {
            self.navigationController?.pushViewController(signinVC, animated: true)
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
    }
    

}
