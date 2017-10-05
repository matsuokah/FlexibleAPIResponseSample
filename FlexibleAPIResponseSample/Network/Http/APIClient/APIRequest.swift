//
//  APIRequest.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/06.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import Alamofire

enum ResponseFormat {
	case json
}

protocol Request {
	var endpoint: URL { get }
	var parameters: Alamofire.Parameters { get }
	var responseFormat: ResponseFormat { get }
	var encoding: ParameterEncoding { get }
}

struct APIRequest<E: Endpoint, P: AlamofireParameters>: Request {
	let apiEndpoint: E
	let apiParameters: P
	var encoding: ParameterEncoding
	
	var endpoint: URL {
		return apiEndpoint.endpoint
	}

	var parameters: Alamofire.Parameters {
		return apiParameters.parameters
	}

	var responseFormat: ResponseFormat {
		return .json
	}
}
