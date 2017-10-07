//
//  APIParameters.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/06.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Alamofire

protocol ParameterKey: Hashable {
	var key: String { get }
}

protocol AlamofireParameters {
	var parameters: Alamofire.Parameters { get }
}

protocol Parameter {
	associatedtype Key: ParameterKey

	var parameter: [Self.Key: Any] { get set }
	mutating func setParameter(_ value: Any, forKey key: Key)
}

extension Parameter {
	mutating func setParameter(_ value: Any, forKey key: Key) {
		parameter[key] = value
	}
	mutating func setParameter<T: RawRepresentable>(_ value: T, forKey key: Key) where T.RawValue == String {
		parameter[key] = value.rawValue
	}
}

extension AlamofireParameters where Self: Parameter {
	var parameters: Alamofire.Parameters {
		return parameter.associate { (key, value) in
			return (key.key, value)
		}
	}
}

extension Dictionary {
	// MARK: Public Methods
	public func associate<NKey, NValue>(transformer: @escaping ((Key, Value) -> (NKey, NValue))) -> Dictionary<NKey, NValue> {
		return reduce(into: [:]) { (result, keyValue) in
			let (key, value) = keyValue
			let pair = transformer(key, value)
			result[pair.0] = pair.1
		}
	}
}
