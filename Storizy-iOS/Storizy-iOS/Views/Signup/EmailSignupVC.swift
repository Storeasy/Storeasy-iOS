//
//  EmailSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class EmailSignupVC: UIViewController {

    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var emailSysMsg: UILabel!
    @IBOutlet weak var emailAgreementMsg: UILabel!
    
    @IBOutlet weak var authTitleLabel: UILabel!
    @IBOutlet weak var authTextField: UITextField!
    @IBOutlet weak var authMsg: UILabel!
    @IBOutlet weak var resendAuthBtn: UIButton!
    
    @IBOutlet weak var sendAuthBtn: UIButton!
    @IBOutlet weak var gotoPWbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAuthInvisible()
    }
    
    // 인증번호 입력 영역 가리기
    func setAuthInvisible(){
        authTitleLabel.isHidden = true
        authTextField.isHidden = true
        authMsg.isHidden = true
        resendAuthBtn.isHidden = true
        
        gotoPWbtn.isHidden = true
        gotoPWbtn.isEnabled = false
    }
    
    // 인증번호 입력 영역 보이기
    func setAuthVisible(){
        emailAgreementMsg.isHidden = true
        
        authTitleLabel.isHidden = false
        authTextField.isHidden = false
        authMsg.isHidden = false
        resendAuthBtn.isHidden = false
        
        //다음버튼 보이기, 활성화
        gotoPWbtn.isHidden = false
        gotoPWbtn.isEnabled = true
        gotoPWbtn.layer.zPosition = 1
        
        //인증번호 전송 버튼 비활성화
        sendAuthBtn.isEnabled = false
    }
    
    // MARK: 회원가입 취소 버튼 클릭
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: 인증번호 전송 버튼 클릭
    @IBAction func sendAuthAction(_ sender: Any) {
        setAuthVisible()
    }
    
    // MARK: 인증번호 재전송 버튼 클릭
    @IBAction func resendAuthAction(_ sender: Any) {
    }
    
    // MARK: 다음 버튼 클릭 (인증번호 확인)
    @IBAction func goPWAction(_ sender: Any) {
        if let pwSignupVC = self.storyboard?.instantiateViewController(identifier: "PWSignupVC") {
            self.navigationController?.pushViewController(pwSignupVC, animated: true)
        }
    }
    
    
}
