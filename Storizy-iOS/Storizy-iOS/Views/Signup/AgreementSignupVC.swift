//
//  AgreementSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class AgreementSignupVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var frameView: UIView!
    
    @IBOutlet weak var prevBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    
    let agreementTitles: [String] = ["서비스 약관 동의", "서비스 유료화 약관 동의"]
    let agreementContents: [String] = ["서비스 약관 내용", "서비스 유료화 약관 내용"]
    
    var signupUser: SignupUser = SignupUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
                guard let finalVC = self.storyboard?.instantiateViewController(identifier: "FinalPageVC") else { return }
                self.navigationController?.pushViewController(finalVC, animated: true)
            } else {
                print(responseCode)
                return
            }
        }
        
    }
    
    // MARK: - UI
    // 이전 BNT
    func borderUI<T: UIView>(_ view: T){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }
    
    // BTNs
    func roundUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
    }
    
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        //border
        borderUI(prevBTN)
        //round
        roundUI(prevBTN)
        roundUI(nextBTN)
        roundUI(frameView)
    }
    
}
