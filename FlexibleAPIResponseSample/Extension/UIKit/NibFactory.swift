//
//  NibFactory.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import UIKit

// MARK: - NibFactory
public protocol NibFactory { }

// MARK: - NibFactory/UIViewController
public extension NibFactory where Self: UIViewController {
	// MARK: Public Methods
	public static func createWithNib() -> Self {
		return Self(nibName: String(describing: self), bundle: Bundle(for: self))
	}
}

// MARK: - NibFactory/UIView
public extension NibFactory where Self: UIView {
	// MARK: Public Methods
	public static func createNib() -> UINib {
		return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
	}

	public static func createWithNib() -> Self {
		return createNib().instantiate(withOwner: self, options: nil).first as! Self
	}
}

extension UIViewController: NibFactory { }
extension UIView: NibFactory { }
