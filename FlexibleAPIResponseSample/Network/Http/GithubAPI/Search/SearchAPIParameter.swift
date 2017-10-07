//
//  SearchAPIParameter.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

enum APIParamerterSort: String {
	case desc
	case asc
}

struct SearchAPIParameter: Parameter {
	var parameter: [SearchAPIParameterKey: Any] = [:]

	typealias Key = SearchAPIParameterKey

	init() { }

	enum SearchAPIParameterKey: String, ParameterKey {
		case q
		case sort
		case order

		var key: String {
			return self.rawValue
		}
	}
}

extension SearchAPIParameter: AlamofireParameters { }
