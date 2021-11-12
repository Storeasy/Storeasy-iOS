//
//  UpdateMyProfileService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation
import Alamofire

struct UpdateProfileService {
    
    static let shared = UpdateProfileService()
    
    func updateProfile(accessToken: String, completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.postUpdateProfileURL
        let header: HTTPHeaders = [ "Content-Type": "application/json"
                                    ,"Authorization": accessToken]
//        let body: Parameters = [
//
//        ]
        let dataRequest = AF.request(url,
                                     method: .post,
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
                    print("프로필 수정 성공")
                    responseCode = .success
                } else {
                    print("프로필 수정 실패")
                    print(body)
                    responseCode = .serverError
                }
                
                // response body 파싱
                let decoder = JSONDecoder()
                guard let responseBody = try? decoder.decode(ResponseData<String>.self, from: body) else { return }
                print(responseBody)
                
                // 응답 결과 전송
                completionHandler(responseCode, responseBody)
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
    }
    
    
}
