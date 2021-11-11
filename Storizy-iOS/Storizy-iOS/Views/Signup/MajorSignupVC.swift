//
//  MajorSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class MajorSignupVC: UIViewController {

    //components
    @IBOutlet weak var enterYearTF: UITextField!
    @IBOutlet weak var univTF: UITextField!
    @IBOutlet weak var majorTF: UITextField!
    
    var signupUser: SignupUser = SignupUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func backToNameBirthSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 다음
    @IBAction func nextToAgreementSignupAction(_ sender: Any) {
        if let agreementSignupVC = self.storyboard?.instantiateViewController(identifier: "AgreementSignupVC") as? AgreementSignupVC {
            signupUser.enterYear = enterYearTF.text
            signupUser.univName = univTF.text
            signupUser.major = majorTF.text
            agreementSignupVC.signupUser = self.signupUser
            self.navigationController?.pushViewController(agreementSignupVC, animated: true)
        }
    }
    

}
