//
//  DataModuleFactory.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

protocol DataModuleFactory {
    func makeBaseHTTPClient() -> HTTPClient
    
    func makeHomeDataSource() -> HomeAPI
}
