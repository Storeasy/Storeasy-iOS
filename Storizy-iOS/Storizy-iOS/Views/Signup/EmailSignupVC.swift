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
    
    @IBOutlet weak var authTitleLabel: UILabel!
    @IBOutlet weak var authTextField: UITextField!
    @IBOutlet weak var authMsg: UILabel!
    @IBOutlet weak var resendAuthBtn: UIButton!
    
    @IBOutlet weak var sendAuthBtn: UIButton!
    @IBOutlet weak var gotoPWbtn: UIButton!
    
    var signupUser: SignupUser = SignupUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAuthInvisible()
        sendAuthBtn.isEnabled = false // 인증번호 전송 비활성화
    }
    
    
    
    // 이메일 형식 검사
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: email)
    }
    
    // 화면 터치시
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드 내리기 (텍스트 편집 끝)
        self.view.endEditing(true)
        //이메일 형식 검사
        if !isValidEmail(EmailTextField.text!) {
            emailSysMsg.text = "이메일 형식이 올바르지 않습니다."
            sendAuthBtn.isEnabled = false // 인증번호 전송 비활성화
        } else {
            emailSysMsg.text = ""
            sendAuthBtn.isEnabled = true // 인증번호 전송 활성화
        }
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
        
        authTitleLabel.isHidden = false
        authTextField.isHidden = false
        authMsg.isHidden = false
        resendAuthBtn.isHidden = false
        
        //다음버튼 보이기, 활성화
        gotoPWbtn.isHidden = false
        gotoPWbtn.isEnabled = true
        gotoPWbtn.layer.zPosition = 10
        
        //인증번호 전송 버튼 비활성화
        sendAuthBtn.isHidden = true
        sendAuthBtn.isEnabled = false
    }
    
    func sendEmailReq(_ email: String) {
        // 인증 메일 전송
        SendAuthEmailService.shared.sendAuthEmail(email) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<String>
                print(body)
                self.authMsg.text = "인증 메일이 전송되었습니다. 5분안에 인증해주세요."
            } else {
                self.authMsg.text = "인증 메일 전송 실패. 다시 시도해주세요."
                print(responseCode)
            }
        }
    }
    
    func checkEmailReq(_ email: String) {
        // 메일 중복 확인
        EmailCheckService.shared.emailCheckService(email) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<String>
                print(body)
                self.emailSysMsg.text = ""
                // 이메일 중복 통과되면 -> 인증 번호 입력란 보이기
                self.setAuthVisible()
            } else {
                // 실패
                self.emailSysMsg.text = "이미 존재하는 이메일입니다."
                print(responseCode)
            }
        }
    }
    
    // MARK: 회원가입 취소 버튼 클릭
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: 인증번호 전송 버튼 클릭
    @IBAction func sendAuthAction(_ sender: Any) {
        let email = EmailTextField.text!
        
        // 메일 중복 확인
        checkEmailReq(email)
        
        // 인증 메일 전송
        sendEmailReq(email)
        
    }
    
    // MARK: 인증번호 재전송 버튼 클릭
    @IBAction func resendAuthAction(_ sender: Any) {
        let email = EmailTextField.text!
        
        // 인증 메일 전송
        SendAuthEmailService.shared.sendAuthEmail(email) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<String>
                print(body)
                self.authMsg.text = "인증 메일이 전송되었습니다. 5분안에 인증해주세요."
            } else {
                self.authMsg.text = "인증 메일 전송 실패. 다시 시도해주세요."
                print(responseCode)
            }
        }
    }
    
    
    // MARK: 다음 버튼 클릭 (인증번호 확인)
    @IBAction func goPWAction(_ sender: Any) {
        // 인증번호 확인
        let email = EmailTextField.text!
        let authNum = authTextField.text!
        let request: [String: String] = [
            "email": email,
            "code": authNum
        ]
        CheckAuthEmailService.shared.checkAuthEmail(request) { responseCode, responseBody in
            if responseCode == .success {
                let body = responseBody as! ResponseData<String>
                print(body)
                if let pwSignupVC = self.storyboard?.instantiateViewController(identifier: "PWSignupVC") as? PWSignupVC {
                    self.signupUser.email = self.EmailTextField.text!
                    pwSignupVC.signupUser = self.signupUser
                    self.navigationController?.pushViewController(pwSignupVC, animated: true)
                }
            } else {
                print(responseCode)
                self.authMsg.text = "인증번호가 올바르지 않습니다.\n다시 시도해주세요."
                if let pwSignupVC = self.storyboard?.instantiateViewController(identifier: "PWSignupVC") as? PWSignupVC {
                    self.signupUser.email = self.EmailTextField.text!
                    pwSignupVC.signupUser = self.signupUser
                    self.navigationController?.pushViewController(pwSignupVC, animated: true)
                }
            }
        }
        if let pwSignupVC = self.storyboard?.instantiateViewController(identifier: "PWSignupVC") as? PWSignupVC {
            self.signupUser.email = self.EmailTextField.text!
            pwSignupVC.signupUser = self.signupUser
            self.navigationController?.pushViewController(pwSignupVC, animated: true)
        }
    }
    
}
