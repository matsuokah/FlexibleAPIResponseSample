//
//  Variable.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import RxSwift

extension Variable {
	var changed: Observable<E> {
		return self.asObservable().skip(1)
	}
}
