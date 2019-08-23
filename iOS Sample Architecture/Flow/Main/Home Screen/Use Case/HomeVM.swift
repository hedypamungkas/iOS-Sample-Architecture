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
    private let loadingState = BehaviorRelay<Bool>(value: false)
    var isLoadingShown: Driver<Bool> {
        return self.loadingState.asDriver().skip(1)
    }
    
    private let disposeBag = DisposeBag()
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    func search(keyword: String) -> Observable<[HomeModelOutput]> {
        let model = HomeModelInput(keyword: keyword)
        let content = BehaviorRelay<[HomeModelOutput]>(value: [])
        
        self.loadingState.accept(true)
        self.repository.requestAPI(model: model)
            .subscribe { (event) in
                self.loadingState.accept(false)
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
