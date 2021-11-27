//
//  MajorSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class MajorSignupVC: UIViewController {

    //components
    @IBOutlet weak var headBarView: UIView!
    
    @IBOutlet weak var enterYearTF: UITextField!
    @IBOutlet weak var univTF: UITextField!
    @IBOutlet weak var majorTF: UITextField!
    
    @IBOutlet weak var prevBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    
    var signupUser: SignupUser = SignupUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    
    // 화면 터치 시
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 닫기
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // 뒤로가기
    @IBAction func backToNameBirthSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 다음
    @IBAction func nextToAgreementSignupAction(_ sender: Any) {
        if let agreementSignupVC = self.storyboard?.instantiateViewController(identifier: "AgreementSignupVC") as? AgreementSignupVC {
            signupUser.enterYear = Int(enterYearTF.text ?? "0")
            signupUser.univName = univTF.text ?? "" + "대학교"
            signupUser.major = majorTF.text ?? ""
            agreementSignupVC.signupUser = self.signupUser
            self.navigationController?.pushViewController(agreementSignupVC, animated: true)
        }
    }
    
    // MARK: - UI
    // TF, 이전 BNT
    func borderUI<T: UIView>(_ view: T){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }
    
    // TF, BTNs
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
        //round
        roundUI(enterYearTF)
        roundUI(univTF)
        roundUI(majorTF)
        roundUI(prevBTN)
        roundUI(nextBTN)

        //border
        borderUI(enterYearTF)
        borderUI(univTF)
        borderUI(majorTF)
        borderUI(prevBTN)
    }
}
