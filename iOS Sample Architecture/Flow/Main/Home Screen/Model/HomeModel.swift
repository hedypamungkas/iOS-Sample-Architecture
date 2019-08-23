//
//  HomeModel.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import Foundation

struct HomeModelInput {
    let keyword: String
}

struct HomeModelOutput {
    let repositoryName: String
    let repositoryImageUrl: URL
    let authorName: String
}
