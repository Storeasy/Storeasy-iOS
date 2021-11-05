//
//  AgreementDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class AgreementDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var agreementTitle: String = "이용 약관"
    var agreementContent: String = "내용"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = agreementTitle
        contentTextView.text = agreementContent
    }
    
    //확인 버튼 클릭시
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
