//
//  UITableView+Registrable.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import Foundation

import UIKit

// MARK: - UITableView
public extension UITableView {
	// MARK: Public Methods
	public func register<T: Registrable>(_ registrableType: T.Type) where T: UITableViewCell {
		switch registrableType {
		case let nibRegistrableType as NibRegistrable.Type:
			register(nibRegistrableType.nib, forCellReuseIdentifier: nibRegistrableType.reuseIdentifier)
		case let classRegistrableType as ClassRegistrable.Type:
			register(classRegistrableType, forCellReuseIdentifier: classRegistrableType.reuseIdentifier)
		default:
			assertionFailure("\(registrableType) is unknown type")
		}
	}

	public func dequeueReusableCell<T: Registrable>(for indexPath: IndexPath) -> T where T: UITableViewCell {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with type \(T.self)")
		}
		return cell
	}
}

// MARK: - UITableView
public extension UITableView {
	// MARK: Public Methods
	public func register<T: Registrable>(_ registrableType: T.Type) where T: UITableViewHeaderFooterView {
		switch registrableType {
		case let nibRegistrableType as NibRegistrable.Type:
			register(nibRegistrableType.nib, forHeaderFooterViewReuseIdentifier: nibRegistrableType.reuseIdentifier)
		case let classRegistrableType as ClassRegistrable.Type:
			register(classRegistrableType, forHeaderFooterViewReuseIdentifier: classRegistrableType.reuseIdentifier)
		default:
			assertionFailure("\(registrableType) is unknown")
		}
	}

	public func dequeueReusableHeaderFooterView<T: Registrable>() -> T where T: UITableViewHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
			fatalError("Could not dequeue HeaderFooterView with type \(T.self)")
		}
		return view
	}
}
