//
//  Endpoint.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/05.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

protocol Endpoint {
	var root: URL { get }
	var endpoint: URL { get }
	var path: String { get }
}
