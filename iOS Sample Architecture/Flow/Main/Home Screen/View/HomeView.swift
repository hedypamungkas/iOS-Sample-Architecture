//
//  HomeView.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import Foundation

protocol HomeView: BaseView {
    var viewModel: HomeVM! { get set }
}
