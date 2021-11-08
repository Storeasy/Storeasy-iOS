//
//  OtherPageDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
        let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC")
        self.navigationController?.pushViewController(otherHomeVC, animated: true)
    }
    
}
