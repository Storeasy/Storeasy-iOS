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

    
    func signupReq(_ signupUser: SignupUser, completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.postSignupURL
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let body: Parameters = [
            "email": signupUser.email ?? "",
            "password": signupUser.pw ?? "",
            "name": signupUser.name ?? "",
            "birthDate": signupUser.birth ?? "",
            "admissionYear": signupUser.enterYear ?? 0,
            "universityName": signupUser.univName ?? "",
            "department": signupUser.major ?? ""
        ]
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                let bodyString = String(data: body, encoding: .utf8)
                print(bodyString)
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 201 {
                    print("회원가입 성공")
                    responseCode = .success
                } else {
                    print("회원가입 실패")
                    print(response)
                    responseCode = .serverError
                }
                
                // response body 파싱
                let decoder = JSONDecoder()
                guard let responseBody = try? decoder.decode(ResponseData<String>.self, from: body) else { return }
                
                // 응답 결과 전송
                completionHandler(responseCode, responseBody)
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
    }
    
    
}
