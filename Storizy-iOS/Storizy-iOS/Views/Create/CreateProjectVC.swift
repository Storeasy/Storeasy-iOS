//
//  CreateProjectVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/07.
//

import UIKit

class CreateProjectVC: UIViewController {

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
