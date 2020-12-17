//
//  NetworkService.swift
//  ElmTestTask
//
//  Created by Andrey on 17/12/2020.
//  Copyright © 2020 Andrey Anoshkin. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkService {
    
    private let baseHost: String = "jsonplaceholder.typicode.com"
    private let configuration = URLSessionConfiguration.default
    
    func getData(method: String, queryItems: [URLQueryItem] = []) -> Promise<FeedItems> {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = self.baseHost
        urlConstructor.path = "/\(method)"

        urlConstructor.queryItems?.append(contentsOf: queryItems)
        
        let request = URLRequest(url: urlConstructor.url!)
        let session = URLSession(configuration: configuration)
        
        return Promise { seal in
            let task = session.dataTask(with: request) { (data, response, apiError) in
                
                if let error = apiError {
                    seal.reject(error)
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let response = try decoder.decode(FeedItems.self, from: data!)
                    seal.fulfill(response)
                } catch let decodingError {
                    debugPrint(decodingError)
                    seal.reject(decodingError)
                }
            }
            task.resume()
        }
    }
}
