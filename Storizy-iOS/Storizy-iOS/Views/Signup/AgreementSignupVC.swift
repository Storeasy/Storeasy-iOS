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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //서비스 유료화 자세히 보기
    @IBAction func serviceChargeAgreementDetailAction(_ sender: Any) {
        performSegue(withIdentifier: "charging", sender: nil)
    }
    
    //회원가입 취소
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //이전 페이지(학교관련)로 이동
    @IBAction func backToMajorSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //회원가입 완료
    @IBAction func completeSignupAction(_ sender: Any) {
        //회원가입 요청 전송
        //로그인 화면으로 이동? -> 하게 해주세요 제발요 이게 제일 편해요 사실 아닌데 이렇게 해야 뷰가 덜 쌓일 것 같아요
        //메인 화면으로 이동?
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
