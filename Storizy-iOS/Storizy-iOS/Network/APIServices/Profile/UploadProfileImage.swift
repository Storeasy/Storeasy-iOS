//
//  UploadProfileImage.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import Foundation
import Alamofire

struct UploadProfileImage {
    
    static let shared = UploadProfileImage()
    
    func uploadProfileImage(accessToken: String, imageData: Data, completionHandler: @escaping (ResponseCode, Any) -> (Void)){

        let url = APIUrls.uploadProfileImageURL
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data"
                                    ,"Authorization": accessToken ]

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "profileImage", fileName: "hyeinisnotfree.jpg", mimeType: "image/jpg")
        }, to: url, method: .post, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let body =  response.value else { return }
                ///
//                let str = String(decoding: body, as: UTF8.self)
//                print(str)
                ///
                // 상태 코드 처리
                var responseCode: ResponseCode = .success
                if status == 201 {
                    print("이미지 업로드 성공")
                    responseCode = .success
                    
                    // response body 파싱
                    let decoder = JSONDecoder()
                    guard let responseBody = try? decoder.decode(ResponseData<String>.self, from: body) else { return }
                    // 응답 결과 전송
                    completionHandler(responseCode, responseBody)
                } else {
                    print("이미지 업로드 실패")
                    print(body)
                    responseCode = .serverError
                    // 응답 결과 전송
                    completionHandler(responseCode, body)
                }
            case .failure(let error):
                print(error)
                completionHandler(.requestError, "request fail")
            }
        }
        
    }
    
    
}
