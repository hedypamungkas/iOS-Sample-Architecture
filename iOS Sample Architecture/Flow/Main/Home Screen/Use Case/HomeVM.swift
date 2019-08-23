//
//  HomeVM.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeVM {
    
    private let repository: HomeRepository
    private let disposeBag = DisposeBag()
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func search(keyword: String) -> Observable<[HomeModelOutput]> {
        let model = HomeModelInput(keyword: keyword)
        let content = BehaviorRelay<[HomeModelOutput]>(value: [])
        
        self.repository.requestAPI(model: model)
            .subscribe { (event) in
                switch event {
                case .error(let err):
                    print(err)
                    content.accept([])
                case .success(let model):
                    content.accept(model)
                }
            }
            .disposed(by: disposeBag)
        
        return content.asObservable()
    }
}
