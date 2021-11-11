//
//  EmailCheckService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/11.
//

import Foundation
import Alamofire

struct EmailCheckService {
    
    static let shared = EmailCheckService()

    
    func emailCheckService(_ email: String, handle: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.checkEmailGetURL + email
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 200 {
                    print("이메일 중복 확인 성공")
                    responseCode = .success
                } else {
                    responseCode = .serverError
                }
                
                // response body 파싱
                let decoder = JSONDecoder()
                guard let responseBody = try? decoder.decode(ResponseData<String>.self, from: body) else { return }
                
                // 응답 결과 전송
                handle(responseCode, responseBody)
            case .failure(let error):
                print(error)
                handle(.requestError, "request fail")
            }
        }
    }
    
    
}
