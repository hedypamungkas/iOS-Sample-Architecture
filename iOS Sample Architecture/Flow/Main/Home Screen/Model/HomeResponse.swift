//
//  HomeResponse.swift
//  iOS Sample Architecture
//
//  Created by Hedy Pamungkas on 23/08/19.
//  Copyright © 2019 hedy. All rights reserved.
//

import Foundation

struct HomeBody: Codable {
    let q: String
}

struct HomeResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [HomeRepositoryResponse]
}

struct HomeRepositoryResponse: Codable {
    let id: Int
    let fullName: String
    let htmlUrl: String
    let description: String?
    let owner: HomeOwnerResponse
}

struct HomeOwnerResponse: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
}
