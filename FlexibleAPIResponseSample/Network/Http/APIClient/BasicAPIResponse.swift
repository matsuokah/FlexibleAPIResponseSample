//
//  BasicResponse.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/05.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Result
import RxSwift

protocol BasicAPIResponse: Decodable {
	associatedtype ResponseT: Decodable
}

protocol APIResult {
	associatedtype ResponseT: Decodable
	associatedtype ErrorT: Swift.Error

	var result: Result<ResponseT, ErrorT> { get }
}

extension Observable {
	func unwrapResult<T, E>() -> Observable<T> where Element == AnyAPIResult<T, E> {
		return self
			.asObservable()
			.map { result in
				switch result.result {
				case .success(let t):
					return t
				case .failure(let e):
					throw e
				}
		}
	}
}

struct AnyAPIResult<ResponseT: Decodable, ErrorT: Swift.Error>: APIResult {

	let _result: () -> Result<ResponseT, ErrorT>
	init<Base: APIResult> (_ base: Base) where Base.ResponseT == ResponseT, Base.ErrorT == ErrorT {
		_result = { () -> Result<ResponseT, ErrorT> in
			return base.result
		}
	}

	var result: Result<ResponseT, ErrorT> {
		return _result()
	}
}

protocol AnyAPIResultConvartibleType: APIResult {
	var anyAPIResult: AnyAPIResult<Self.ResponseT, Self.ErrorT> { get }
}

extension AnyAPIResultConvartibleType {
	var anyAPIResult: AnyAPIResult<Self.ResponseT, Self.ErrorT> {
		return AnyAPIResult(self)
	}
}
