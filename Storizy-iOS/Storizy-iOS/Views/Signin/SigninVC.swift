//
//  SigninVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/04.
//

import UIKit

class SigninVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var signinBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        UserDefaults.standard.setValue("email", forKey: "email")
//        UserDefaults.standard.removeObject(forKey: "email")
//        UserDefaults.standard.key
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - 뒤로가기 버튼 클릭
    // 스플래시 화면으로 이동
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 로그인 시도
    @IBAction func signinAction(_ sender: Any) {
        let email = emailTF.text!
        let pw = pwTF.text!
        
        //서버로 로그인 요청 전송
        SigninService.shared.signinReq(email: email, pw: pw) { (responseCode, responseBody) in
            // 로그인 성공
            if responseCode == .success {
                let body = responseBody as! ResponseData<SigninResponseData>
                print(body)
                
                // access token 저장
                let accessToken = body.data?.accessToken
                UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
                print(UserDefaults.standard.string(forKey: "accessToken"))
                //성공시 탭바C으로 이동
                let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
                let tabBarController = tabBarStoryboard.instantiateViewController(identifier: "TabBarController")
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
            // 로그인 실패
            else {
                print(responseCode)
                //에러 처리 (alert로)
            }
        }
        
    }
    
    // MARK: - UI
    
    func frameUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
        view.clipsToBounds = true
    }
    
    func setUI(){
        frameUI(emailTF)
        frameUI(pwTF)
        
        signinBTN.layer.cornerRadius = 12
    }
    
}
