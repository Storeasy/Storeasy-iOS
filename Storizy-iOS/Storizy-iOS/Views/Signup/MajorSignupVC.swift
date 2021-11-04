//
//  MajorSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class MajorSignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backToNameBirthSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextToAgreementSignupAction(_ sender: Any) {
        if let agreementSignupVC = self.storyboard?.instantiateViewController(identifier: "AgreementSignupVC") {
            self.navigationController?.pushViewController(agreementSignupVC, animated: true)
        }
    }
    

}
