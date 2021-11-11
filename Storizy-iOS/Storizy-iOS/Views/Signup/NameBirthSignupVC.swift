//
//  NameBirthSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class NameBirthSignupVC: UIViewController {

    //components
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthTF: UITextField!
    
    var signupUser: SignupUser = SignupUser()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 화면 터치 시
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 닫기
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // 뒤로가기
    @IBAction func backToPWSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // 다음
    @IBAction func nextToMajorSignupAction(_ sender: Any) {
        if let majorSignupVC = self.storyboard?.instantiateViewController(identifier: "MajorSignupVC") as? MajorSignupVC {
            signupUser.name = nameTF.text!
            signupUser.birth = birthTF.text!
            majorSignupVC.signupUser = self.signupUser
            self.navigationController?.pushViewController(majorSignupVC, animated: true)
        }
    }

    // VC end
}
