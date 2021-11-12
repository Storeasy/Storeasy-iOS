//
//  AgreementSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class AgreementSignupVC: UIViewController {

    let agreementTitles: [String] = ["서비스 약관 동의", "서비스 유료화 약관 동의"]
    let agreementContents: [String] = ["서비스 약관 내용", "서비스 유료화 약관 내용"]
    
    var signupUser: SignupUser = SignupUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(signupUser)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AgreementDetailVC
        if segue.identifier == "service" {
            vc.agreementTitle = agreementTitles[0]
            vc.agreementContent = agreementContents[0]
        } else {
            vc.agreementTitle = agreementTitles[1]
            vc.agreementContent = agreementContents[1]
        }
    }
    
    //서비스 약관 자세히 보기
    @IBAction func serviceAgreementDetailAction(_ sender: Any) {
        performSegue(withIdentifier: "service", sender: nil)
    }
    
    //회원가입 취소
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // 뒤로가기
    @IBAction func backToMajorSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //회원가입 완료
    @IBAction func completeSignupAction(_ sender: Any) {
        //회원가입 요청 전송
        SignupService.shared.signupReq(signupUser) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<String>
                print(body)
                
                //로그인 화면으로 이동
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(responseCode)
            }
        }
    }
    
}
