//
//  ModuleFactoryImpl+Repository.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

extension ModuleFactoryImpl: RepositoryModuleFactory {
    
    func makeHomeRepository() -> HomeRepository {
        return HomeRepositoryImpl(dataSource: makeHomeDataSource())
    }
}
