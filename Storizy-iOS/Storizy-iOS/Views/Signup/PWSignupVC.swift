//
//  PWSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class PWSignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backToEmailSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextToNameBirthAction(_ sender: Any) {
        if let nameBirthSignupVC = self.storyboard?.instantiateViewController(identifier: "NameBirthSignupVC") as? NameBirthSignupVC {
            self.navigationController?.pushViewController(nameBirthSignupVC, animated: true)
        }
    }

}
