//
//  MainCoordinator.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import Foundation

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    private let router: Router
    private let factory: MainModuleFactory
    
    init(router: Router, factory: MainModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showHomeView()
    }
    
    private func showHomeView() {
        let view = factory.makeHomeView()
        router.setRootModule(view, hideBar: true)
    }
}
