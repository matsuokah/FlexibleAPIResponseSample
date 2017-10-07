//
//  SearchAPI.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/06.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import RxSwift
import Alamofire

protocol APIService {
	var client: APIClient { get }
}

protocol SearchAPI: APIService {
	func searchRepository(q: String) -> Observable<[GithubRepositoryDTO]>
}

struct SearchAPIService: SearchAPI {

	var client: APIClient {
		return _client
	}

	var _client = GithubAPIClient()

	func searchRepository(q: String) -> Observable<[GithubRepositoryDTO]> {
		var parameter = SearchAPIParameter()
		parameter.setParameter(q, forKey: .q)
		return client.get(apiRequest: APIRequest(apiEndpoint: GithubSearchAPIEndpoint.repositories, apiParameters: parameter, encoding: URLEncoding.default))
	}
}
