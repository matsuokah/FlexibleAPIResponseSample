//
//  UITableView+Rx.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import UIKit

import RxSwift

extension Reactive where Base: UITableView {
	public func items < S: Sequence, Cell: UITableViewCell & NibRegistrable, O: ObservableType >
	(cellType: Cell.Type = Cell.self)
		-> (_ source: O)
		-> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
		-> Disposable
	where O.E == S {
		return self.items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType.self)
	}
}
