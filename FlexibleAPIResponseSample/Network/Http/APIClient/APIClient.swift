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

fileprivate final class DispatchQueueManager {
	static let shared = DispatchQueueManager()

	let queue: DispatchQueue

	private init() {
		queue = DispatchQueue(label: "", qos: .userInitiated, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: .inherit, target: nil)
	}
}

protocol APIClient {
	var sessionManager: SessionManager { get }
	func get<Response: Decodable>(apiRequest: Request) -> Observable<Response>
}

internal extension APIClient {
	internal func _get<Response>(apiRequest: Request) -> Observable<Response> where Response: Decodable {
		return request(method: .get, apiRequest: apiRequest)
	}
}

private extension APIClient {
	private func request<Response: Decodable>(method: HTTPMethod, apiRequest: Request) -> Observable<Response> {
		return Single.create { observer in
			weak var request = self.sessionManager.request(apiRequest.endpoint, method: method, parameters: apiRequest.parameters, encoding: apiRequest.encoding)
			request?
				.validate()
				.debugLog()
				.responseData(queue: DispatchQueueManager.shared.queue) {
					self.handleResponse(response: $0, observer: observer)
			}
			return Disposables.create {
				request?.cancel()
			}
		}.asObservable()
	}

	private func handleResponse<Response: Decodable>(response: DataResponse<Data>, observer: ((SingleEvent<Response>) -> Void)) {
		guard let data = response.data else {
			return observer(.error(APIError()))
		}

		let jsonDecoder = JSONDecoder()
		do {
			let parsed = try jsonDecoder.decode(Response.self, from: data)
			observer(.success(parsed))
		} catch let error {
			NSLog("\(error)")
			NSLog("\(String(data: data, encoding: .utf8) ?? "")")
			observer(.error(error))
		}
	}
}

private extension DataRequest {
	func debugLog() -> Self {
		NSLog("\(self.description)")
		return self
	}
}
