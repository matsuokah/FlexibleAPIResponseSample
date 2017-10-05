//
//  GithubAPIClient.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/06.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift

struct GithubAPIClient: APIClient {
	var sessionManager: SessionManager
	
	init() {
		sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
	}
}

extension GithubAPIClient {
	func get<Response>(apiRequest: Request) -> Observable<Response> where Response : Decodable {
		typealias BasicResponse = GithubAPIResponseBase<Response>
		return _get(apiRequest: apiRequest)
			.map { (res: BasicResponse) in
				return res.anyAPIResult
			}
			.unwrapResult()
	}
}
