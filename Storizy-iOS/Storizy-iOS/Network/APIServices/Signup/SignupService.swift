//
//  SignupService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/11.
//

import Foundation
import Alamofire

struct SignupService {
    static let shared = SignupService()
    
    func signupRequest(_ signupUser: SignupUser){
        let url = APIUrls.signupPostURL
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let body: Parameters = [
            "email": signupUser.email!,
            "password": signupUser.pw!,
            "name": signupUser.name!,
            "birthDate": signupUser.birth!,
            "admissionYear": signupUser.enterYear!, //숫자로 변환
            "universityName": signupUser.univName!,
            "department": signupUser.major!
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default, headers: header)
        
        dataRequest.responseJSON() { response in
            switch response.result {
            case .success:
                if let data = try! response.result.get() as? [String: Any] {
                  print(data)
                }
                break
            case .failure:
                break
            }
        }
    }
}
