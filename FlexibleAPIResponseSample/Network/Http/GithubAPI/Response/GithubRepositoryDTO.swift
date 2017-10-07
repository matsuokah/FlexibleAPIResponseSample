//
//  GithubRepository.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

struct GithubRepositoryDTO: Decodable {
	let id: Int
	let name: String
	let full_name: String
	let owner: GithubOwnerDTO
	let `private`: Bool
	let html_url: String
	let description: String?
	let fork: Int
	let url: String
	let created_at: String
	let updated_at: String
	let pushed_at: String
	let homepage: String?
	let size: Int
	let stargazers_count: Int
	let watchers_count: Int
	let language: String?
	let forks_count: Int
	let open_issues_count: Int
	let default_branch: String
	let score: Float
}
