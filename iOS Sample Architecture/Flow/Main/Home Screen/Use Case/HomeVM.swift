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
    
    struct Output {
        let error: Driver<Error?>
        let content: Driver<[HomeModelOutput]>
    }
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func search(keyword: String) -> Output {
        let model = HomeModelInput(keyword: keyword)
        let error = BehaviorRelay<Error?>(value: nil)
        let content = BehaviorRelay<[HomeModelOutput]>(value: [])
        
        self.repository.requestAPI(model: model)
            .subscribe { (event) in
                switch event {
                case .error(let err):
                    error.accept(err)
                case .success(let model):
                    content.accept(model)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(error: error.asDriver().skip(1),
                      content: content.asDriver().skip(1))
    }
}
