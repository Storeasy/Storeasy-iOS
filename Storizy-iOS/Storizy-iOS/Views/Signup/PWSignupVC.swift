//
//  PWSignupVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class PWSignupVC: UIViewController {

    //components
    @IBOutlet weak var headBarView: UIView!
    
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var pw2TF: UITextField!
    @IBOutlet weak var pwMsgLabel: UILabel!
    @IBOutlet weak var pw2MsgLabel: UILabel!
    
    @IBOutlet weak var prevBTN: UIButton!
    @IBOutlet weak var nextBTN: UIButton!
    
    
    var isValid: Bool = false
    var signupUser: SignupUser = SignupUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        print(signupUser.email)
    }
    
    // 비밀번호 검사
    func isValidPw(_ pw: String) -> Bool {
        let pwRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
        let pwCheck = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        return pwCheck.evaluate(with: pw)
    }
    
    
    // 화면 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 편집 종료
        self.view.endEditing(true)
        if pwTF.hasText {
            if isValidPw(pwTF.text!) {
                pwMsgLabel.text = ""
            } else {
                pwMsgLabel.text = "비밀번호 형식이 올바르지 않습니다."
            }
        }
        if pw2TF.hasText {
            if pw2TF.text == pwTF.text {
                isValid = isValidPw(pw2TF.text!)
                pw2MsgLabel.text = ""
            } else {
                pw2MsgLabel.text = "비밀번호가 일치하지 않습니다."
            }
        }
        
    }
    
    // 닫기 버튼
    @IBAction func giveupSignupAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // 뒤로가기
    @IBAction func backToEmailSignupAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 다음
    @IBAction func nextToNameBirthAction(_ sender: Any) {
        if let nameBirthSignupVC = self.storyboard?.instantiateViewController(identifier: "NameBirthSignupVC") as? NameBirthSignupVC {
            signupUser.pw = pwTF.text!
            nameBirthSignupVC.signupUser = self.signupUser
            self.navigationController?.pushViewController(nameBirthSignupVC, animated: true)
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
        roundUI(pwTF)
        roundUI(pw2TF)
        roundUI(prevBTN)
        roundUI(nextBTN)

        //border
        borderUI(pwTF)
        borderUI(pw2TF)
        borderUI(prevBTN)

    }

}
