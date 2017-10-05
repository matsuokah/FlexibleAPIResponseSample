//
//  GithubAPIEndpoint.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/05.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

// MARK: - GitHubAPIEndpoint
protocol GitHubAPIEndpoint: Endpoint {
	var functionPath: String { get }
}

extension GitHubAPIEndpoint {
	var root: URL {
		return URL(string: URLConstants.GithubAPIURLRoot)!
	}
	
	var endpoint: URL {
		return root.appendingPathComponent([functionPath, path].joined(separator: "/"))
	}
}


// MARK: - GithubSearchAPIEndpoint
enum GithubSearchAPIEndpoint: String, GitHubAPIEndpoint {
	case repositories
	
	var path: String {
		return self.rawValue
	}

	var functionPath: String {
		return "search"
	}
}
