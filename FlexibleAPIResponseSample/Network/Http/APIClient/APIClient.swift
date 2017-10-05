//
//  APIClient.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/05.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift
import Result

protocol APIClient {
	var sessionManager: SessionManager { get }
	func get<Response: Decodable>(apiRequest: Request) -> Observable<Response>
}

internal extension APIClient {
	internal func _get<Response>(apiRequest: Request) -> Observable<Response> where Response: Decodable {
		return request(method: .get, apiRequest: apiRequest)
	}
}

struct APIError: Error {}

private extension APIClient {
	private func request<Response: Decodable>(method: HTTPMethod, apiRequest: Request) -> Observable<Response> {
		return Single<Response>.create { single in
			weak var request = self.sessionManager.request(apiRequest.endpoint, method: method, parameters: apiRequest.parameters, encoding: apiRequest.encoding)
			request?
				.validate()
				.responseData {
					self.handleResponse(response: $0, single: single)
			}
			return Disposables.create {
				request?.cancel()
			}
		}.asObservable()
	}

	private func handleResponse<Response: Decodable>(response: DataResponse<Data>, single: (SingleEvent<Response>) -> ()) {
		guard let data = response.data else {
			return single(.error(APIError()))
		}
		
		let jsonDecoder = JSONDecoder()
		do {
			let parsed = try jsonDecoder.decode(Response.self, from: data)
			single(.success(parsed))
		} catch let error {
			single(.error(error))
		}
	}
}
