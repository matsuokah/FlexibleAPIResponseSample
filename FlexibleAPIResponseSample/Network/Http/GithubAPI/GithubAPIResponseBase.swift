//
//  GithubAPIResponseBase.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/06.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Result

struct GithubAPIResponseBase<T: Decodable>: BasicAPIResponse {
	typealias ResponseT = T
	typealias ErrorT = APIError

	private let total_count: Int
	private let incomplete_results: Bool
	private let items: ResponseT?
}

extension GithubAPIResponseBase: APIResult {
	var result: Result<ResponseT, APIError> {
		guard let response = items else { return .failure(APIError()) }
		return .success(response)
	}
}

extension GithubAPIResponseBase: AnyAPIResultConvartibleType { }
