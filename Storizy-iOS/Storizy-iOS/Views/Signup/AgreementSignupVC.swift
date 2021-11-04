//
//  AgreementSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class AgreementSignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backToMajorSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeSignupAction(_ sender: Any) {
        //회원가입 요청 전송
        //로그인 화면으로 이동? -> 하게 해주세요 제발요 이게 제일 편해요 사실 아닌데 이렇게 해야 뷰가 덜 쌓일 것 같아요
        //메인 화면으로 이동?
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
