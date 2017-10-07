//
//  Registrable.swift
//  FlexibleAPIResponseSample
//
//  Created by matsuokah on 2017/10/07.
//  Copyright © 2017 matsuokah. All rights reserved.
//

import UIKit

// MARK: - Registrable
public protocol Registrable: class {
	static var reuseIdentifier: String { get }
}

// MARK: - Registrable
public extension Registrable {
	// MARK: Public Properties
	public static var reuseIdentifier: String {
		return String(describing: self)
	}
}

// MARK: - ClassRegistrabne
public protocol ClassRegistrable: Registrable { }

// MARK: - ClassRegistrabne
public protocol NibRegistrable: Registrable {
	static var nib: UINib { get }
}

// MARK: - NibRegistrable
public extension NibRegistrable where Self: UIView {
	// MARK: Public Properties
	public static var nib: UINib {
		return Self.createNib()
	}
}
