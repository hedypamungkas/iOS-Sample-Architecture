//
//  HomeVC.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import RxSwift
import RxCocoa
import Kingfisher

class HomeVC: UIViewController, HomeView {
    
    var viewModel: HomeVM!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCellWhenTapped()
    }
    
    private func setupSearchBar() {
        let searchResult = self.searchBar.rx.text.orEmpty
                                .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                                .distinctUntilChanged()
                                .flatMapLatest { query -> Observable<[HomeModelOutput]> in
                                    if query.isEmpty {
                                        return .just([])
                                    }
                                    return self.searchRequest(keyword: query)
                                        .catchErrorJustReturn([])
                                }
                                .observeOn(MainScheduler.instance)
        
        searchResult
            .bind(to: tableView.rx.items) { ( tableView: UITableView, index: Int, element: HomeModelOutput) in
                return self.setupTableView(dataSource: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCellWhenTapped() {
        tableView.rx.modelSelected(HomeModelOutput.self)
            .subscribe(onNext: { (model) in
                UIApplication.shared.open(model.repositoryUrl, options: [:], completionHandler: nil)
            }).disposed(by: disposeBag)
    }
    
    private func setupTableView(dataSource: HomeModelOutput) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.imageView?.kf.setImage(with: dataSource.repositoryImageUrl)
        cell.textLabel?.text = dataSource.repositoryName
        cell.detailTextLabel?.text = dataSource.authorName
        return cell
    }
    
    private func searchRequest(keyword: String) -> Observable<[HomeModelOutput]> {
        let result = viewModel.search(keyword: keyword)
        return result
    }

}
