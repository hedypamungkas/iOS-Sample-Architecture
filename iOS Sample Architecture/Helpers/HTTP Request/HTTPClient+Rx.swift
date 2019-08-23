//
//  HTTPClient+Rx.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift

protocol ClientAPI {
    var httpClient: HTTPClient { get }
}

protocol HTTPClient {
    var baseUrl: URL { get }
}

extension HTTPClient {
    func send<T: Codable>(request apiRequest: HTTPRequest) -> Single<T> {
        return Single<T>.create { single in
            let request = apiRequest.request(with: self.baseUrl)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, _, _) in
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model: T = try decoder.decode(T.self, from: data ?? Data())
                    single(.success(model))
                } catch let error {
                    single(.error(error))
                }
            })
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
