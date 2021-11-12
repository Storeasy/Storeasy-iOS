//
//  ResponseData.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/12.
//

import Foundation

struct ResponseData<T: Codable>: Codable{
    let status: Int
    let code: String
    let message: String
    let data: T?
    
//    enum CodingKeys: String, CodingKey {
//        case status = "status"
//        case code = "code"
//        case message = "message"
//        case data = "data"
//    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
//        code = (try? values.decode(String.self, forKey: .code)) ?? ""
//        message = (try? values.decode(String.self, forKey: .message)) ?? ""
//        data = (try? values.decode(T.self, forKey: .data)) ?? nil
//    }
}
