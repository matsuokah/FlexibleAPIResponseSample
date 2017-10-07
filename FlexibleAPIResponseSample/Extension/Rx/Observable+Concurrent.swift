//
//  Observable+Concurrent.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import RxSwift


struct SchedulerManager {

	static let shared = SchedulerManager()
	let scheduler: ImmediateSchedulerType

	init() {
		let operationQueue = OperationQueue()
		operationQueue.qualityOfService = QualityOfService.userInitiated
		operationQueue.maxConcurrentOperationCount = 4

		scheduler = OperationQueueScheduler(operationQueue: operationQueue)
	}
}

// MARK: - Observable
public extension Observable {
	/// subscribeを並列スレッドで行います
	public func subscribeOnConcurrent() -> Observable {
		return subscribeOn(SchedulerManager.shared.scheduler)
	}

	public func observeOnMain() -> Observable {
		return observeOn(MainScheduler.instance)
	}
}
