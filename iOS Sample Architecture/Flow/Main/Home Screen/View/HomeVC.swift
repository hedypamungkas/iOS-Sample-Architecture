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
    }
    
    private func setupSearchBar() {
        self.searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: SchedulerProvider.shared.main)
            .distinctUntilChanged()
            .subscribe(onNext: { (keyword) in
                if !keyword.isEmpty {
                    self.searchRequest(keyword: keywords)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func searchRequest(keyword: String) {
        let result = viewModel.search(keyword: keyword)
        result.error
            .drive(onNext: { (error) in
                print(error?.domain ?? "")
            })
            .disposed(by: disposeBag)
        
        result.content
            .asObservable()
            .bind(to: tableView.rx.items) { ( tableView: UITableView, index: Int, element: HomeModelOutput) in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
                cell.imageView?.kf.setImage(with: element.repositoryImageUrl)
                cell.textLabel?.text = element.repositoryName
                cell.detailTextLabel?.text = element.authorName
                return cell
            }
            .disposed(by: disposeBag)
    }

}
