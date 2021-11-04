//
//  NameBirthSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class NameBirthSignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backToPWSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func nextToMajorSignupAction(_ sender: Any) {
        if let majorSignupVC = self.storyboard?.instantiateViewController(identifier: "MajorSignupVC") {
            self.navigationController?.pushViewController(majorSignupVC, animated: true)
        }
    }
    
    
    

}
