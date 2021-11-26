//
//  SearchStoryService.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/26.
//

import Foundation
import Alamofire

struct SearchStoryService {
    static let shared = SearchStoryService()
    
    func getSearchedStory(accessToken: String, tagId: Int, completionHandler: @escaping (ResponseCode, Any) -> (Void)) {

        let url = APIUrls.getMySearchedStoryURL
        let header: HTTPHeaders = [ "Content-Type": "application/json"
                                    ,"Authorization": accessToken]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: [ "tag": tagId ],
                                     encoding: URLEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { print("###"); return }
//                let str = String(decoding: body, as: UTF8.self)
//                print(str)
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 200 {
                    print("성공")
                    responseCode = .success
                    // response body 파싱
                    let decoder = JSONDecoder()
                    guard let responseBody = try? decoder.decode(ResponseData<[Story]>.self, from: body) else { print("!!!"); return }
                    print(responseBody)
                    // 응답 결과 전송
                    completionHandler(responseCode, responseBody)
                } else {
                    print("실패")
                    print(body)
                    responseCode = .serverError
                    completionHandler(responseCode, "error")
                }
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
    }
}
