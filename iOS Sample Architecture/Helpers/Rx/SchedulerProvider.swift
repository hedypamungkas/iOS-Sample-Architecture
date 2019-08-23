//
//  SchedulerProvider.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift

class SchedulerProvider {
    
    static let shared: SchedulerProvider = SchedulerProvider()
    
    let main = MainScheduler.instance
    let background = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)
    
    private init() {
        
    }
    
}
