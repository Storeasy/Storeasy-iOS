//
//  EditProfileVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/10.
//

import UIKit

class EditProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료
    @IBAction func completeAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

    }
}
