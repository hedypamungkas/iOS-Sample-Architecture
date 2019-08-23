//
//  HomeRepositoryImpl.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift

class HomeRepositoryImpl: HomeRepository {
    
    private let dataSource: HomeAPI
    private let disposeBag = DisposeBag()
    
    init(dataSource: HomeAPI) {
        self.dataSource = dataSource
    }
    
    func requestAPI(model: HomeModelInput) -> Single<[HomeModelOutput]> {
        return Single.create(subscribe: { (observer) in
            self.dataSource.request(parameters: self.inputTransformJson(from: model))
                .map({ (response) -> [HomeModelOutput] in
                    return self.outputTransformModel(from: response)
                })
                .subscribe(onSuccess: { (model) in
                    observer(.success(model))
                }, onError: { (err) in
                    observer(.error(err))
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        })
    }
    
    private func inputTransformJson(from object: HomeModelInput) -> [String: Any] {
        let body = HomeBody(q: object.keyword)
        if let param = body.dictionary {
            return param
        }
        return [String: Any]()
    }
    
    private func outputTransformModel(from object: HomeResponse) -> [HomeModelOutput] {
        let model = object.items.map { (response) -> HomeModelOutput in
            return HomeModelOutput(repositoryName: response.fullName,
                                   repositoryImageUrl: URL(string: response.owner.avatarUrl)!,
                                   repositoryUrl: URL(string: response.htmlUrl)!,
                                   repositoryDescription: response.description ?? "",
                                   authorName: response.owner.login)
        }
        return model
    }
}
