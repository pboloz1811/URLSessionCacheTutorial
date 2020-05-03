//
//  URLSessionService.swift
//  URLSession
//
//  Created by Patryk on 01/05/2020.
//  Copyright © 2020 Patryk. All rights reserved.
//

import Foundation




class URLSessionService {
    
    private let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
    
    private lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        let session = URLSession(configuration: sessionConfiguration, delegate: URLSessionServiceDelegate(), delegateQueue: nil)
        return session
    }()
    
    func sendRequest() {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request), let response = String(data: cachedResponse.data, encoding: .utf8) {
            print(cachedResponse.userInfo)
            print(response)
        } else {
            let task = session.dataTask(with: request) 
            task.resume()
        }
    }
}

class URLSessionServiceDelegate: NSObject, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        let date = Date()
        let response = CachedURLResponse(response: proposedResponse.response,
                          data: proposedResponse.data,
                          userInfo: [ "Date": date ],
                          storagePolicy: .allowedInMemoryOnly)
        completionHandler(response)
    }
}
