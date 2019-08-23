//
//  HomeAPIImpl.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift

class HomeAPIImpl: HomeAPI {
    
    private class HomeRequest: HTTPRequest {
        var method = HTTPMethods.GET
        var path = "/search/repositories"
        var parameters: [String: Any]
        
        init(parameters: [String: Any]) {
            self.parameters = parameters
        }
    }
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func request(parameters: [String: Any]) -> Single<HomeResponse> {
        return httpClient.send(request: HomeRequest(parameters: parameters))
    }
}
