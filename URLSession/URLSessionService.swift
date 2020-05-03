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
    
    
    private lazy var cache: URLCache = {
        let cache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 40 * 1024 * 1024, diskPath: "my-cache")
        return cache
    }()
    
    private lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .returnCacheDataElseLoad
        sessionConfiguration.urlCache = cache
        let session = URLSession(configuration: sessionConfiguration, delegate: URLSessionServiceDelegate(), delegateQueue: nil)
        return session
    }()
    
    func sendRequest() {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request)
        task.resume()
    }
}

class URLSessionServiceDelegate: NSObject, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        let date = Date()
        let response = CachedURLResponse(response: proposedResponse.response,
                          data: proposedResponse.data,
                          userInfo: [ "Date": date ],
                          storagePolicy: .allowed)
        completionHandler(response)
    }
}
