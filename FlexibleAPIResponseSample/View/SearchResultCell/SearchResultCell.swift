//
//  SearchResultCell.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import UIKit

final class SearchResultCell: UITableViewCell, NibRegistrable {
	@IBOutlet weak var repositoryName: UILabel!

	func setData(data: GithubRepositoryDTO) {
		repositoryName.text = data.full_name
	}
}
