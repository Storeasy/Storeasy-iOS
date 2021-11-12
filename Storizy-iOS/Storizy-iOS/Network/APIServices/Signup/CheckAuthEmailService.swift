//
//  CheckAuthEmailService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation
import Alamofire

struct CheckAuthEmailService {
    
    static let shared = CheckAuthEmailService()

    
    func checkAuthEmail(_ body: [String: String], completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.authEmailGetURL
        let header: HTTPHeaders = [ "Content-Type":"application/json"]
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: body,
                                     encoding: URLEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                
                print(response.request)
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 200 {
                    print("인증 번호 확인 성공")
                    responseCode = .success
                } else {
                    print("인증 번호 확인 실패")
                    print(body)
                    print(status)
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
