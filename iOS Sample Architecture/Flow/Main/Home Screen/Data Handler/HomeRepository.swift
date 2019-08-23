//
//  HomeRepository.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift

protocol HomeRepository {
    func requestAPI(model: HomeModelInput) -> Single<[HomeModelOutput]>
}
