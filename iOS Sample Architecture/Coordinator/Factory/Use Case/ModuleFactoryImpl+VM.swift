//
//  ModuleFactoryImpl+VM.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

extension ModuleFactoryImpl: VMModuleFactory {
    
    func makeHomeVM() -> HomeVM {
        return HomeVM(repository: makeHomeRepository())
    }
}
