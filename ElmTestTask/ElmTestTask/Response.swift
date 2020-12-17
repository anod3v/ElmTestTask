//
//  Response.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

struct Response<T: Codable>: Codable {
    let data: T
    
//    enum CodingKeys: String, CodingKey {
//        case data = ""
//    }
}
