//
//  ModuleFactoryImple+Main.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import Foundation

extension ModuleFactoryImpl: MainModuleFactory {
    
    func makeHomeView() -> HomeView {
        let vc = HomeVC()
        vc.viewModel = makeHomeVM()
        return vc
    }
    
}
