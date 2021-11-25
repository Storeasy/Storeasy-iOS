//
//  SplashViewController.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var frameView: UIView!
    
    @IBOutlet weak var signupBTN: UIButton!
    @IBOutlet weak var signinBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func signinAction(_ sender: Any) {
        if let signinVC = self.storyboard?.instantiateViewController(identifier: "SigninVC") {
            self.navigationController?.pushViewController(signinVC, animated: true)
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        let signupVC = storyboard.instantiateViewController(identifier: "EmailSignupVC")
        self.navigationController?.pushViewController(signupVC, animated: true)

    }
    
    // UI
    func setUI(){
        frameView.layer.cornerRadius = frameView.bounds.height / 2
        signupBTN.layer.cornerRadius = 12
        signinBTN.layer.cornerRadius = 12
    }
    

}
