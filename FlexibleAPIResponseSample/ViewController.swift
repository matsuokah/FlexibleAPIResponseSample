//
//  ViewController.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/05.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

	let disposeBag = DisposeBag()

	@IBOutlet weak var tableView: UITableView!
	let searchModel = GithubSearchModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		tableView.register(SearchResultCell.self)

		bind()
		searchModel.search(q: "Rx")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

private extension ViewController {
	func bind() {
		searchModel
			.searchResult
			.asObservable()
			.bind(to: tableView.rx.items(cellType: SearchResultCell.self)) { (row, element, cell) in
				cell.setData(data: element)
			}
			.disposed(by: disposeBag)
	}
}
