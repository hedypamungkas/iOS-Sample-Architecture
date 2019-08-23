//
//  ModuleFactoryImpl+Data.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

class ModuleFactoryImpl: DataModuleFactory {
    
    func makeBaseHTTPClient() -> HTTPClient {
        return URLClient()
    }
    
    func makeHomeDataSource() -> HomeAPI {
        return HomeAPIImpl(httpClient: makeBaseHTTPClient())
    }
}
