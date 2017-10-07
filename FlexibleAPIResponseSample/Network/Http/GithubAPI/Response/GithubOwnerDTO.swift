//
//  GithubOwnerDTO.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

struct GithubOwnerDTO: Decodable {
	let login: String
	let id: Int
	let avatar_url: String
	let gravatar_id: String
	let url: String
	let received_events_url: String
	let type: String
}
