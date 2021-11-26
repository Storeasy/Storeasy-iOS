//
//  CreateTagService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//

import Foundation
import Alamofire

struct CreateColorTagService {
    
    static let shared = CreateColorTagService()
    
    func createColorTag (accessToken: String, tagName: String, tagColorId: Int, completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.postAddColorTagURL
        let header: HTTPHeaders = [ "Content-Type": "application/json"
                                    ,"Authorization": accessToken]
        let body: Parameters = [
            "name" : tagName,
            "tagColorId" : tagColorId
        ]
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: header).responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 201 {
                    print("성공")
                    responseCode = .success
                    
                    // response body 파싱
                    let decoder = JSONDecoder()
                    guard let responseBody = try? decoder.decode(ResponseData<TagData>.self, from: body) else { print("디코드 오류"); return }
                    
                    // 응답 결과 전송
                    completionHandler(responseCode, responseBody)
                } else {
                    print("실패")
                    print(response)
                    responseCode = .serverError
                    completionHandler(.serverError, "serverError")
                }
                
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
        
    }
    
    
}
