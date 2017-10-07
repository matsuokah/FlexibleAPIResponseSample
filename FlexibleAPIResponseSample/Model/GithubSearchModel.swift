//
//  GithubSearchModel.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import RxSwift

struct GithubSearchModel {
	let searchAPI: SearchAPI = SearchAPIService()
	let disposeBag = DisposeBag()
	let searchResult: Variable<[GithubRepositoryDTO]> = Variable([])

	private let query = Variable("")

	init() {
		bind()
	}

	func search(q: String) {
		self.query.value = q
	}
}

extension GithubSearchModel {
	func bind() {
		query.changed
			.distinctUntilChanged()
			.flatMap { q in
				return self.searchAPI.searchRepository(q: q)
			}
			.subscribeOnConcurrent()
			.observeOnMain()
			.subscribe(onNext: { result in
				self.searchResult.value = result
			}).disposed(by: disposeBag)
	}
}
