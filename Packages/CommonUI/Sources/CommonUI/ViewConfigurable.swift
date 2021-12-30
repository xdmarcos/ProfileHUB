//
// ViewConfigurable.swift
// CommonUI
//
// Created by Marcos González on 2021.
// 
//

import UIKit

public protocol ViewConfigurable where Self: UIView {
	associatedtype ViewModel
	func configure(viewModel: ViewModel)
}

public protocol ViewCellConfigurable: ViewConfigurable {
	static var reuseIdentifier: String { get }
}

public extension ViewCellConfigurable {
	static var reuseIdentifier: String {
		String(describing: self)
	}
}
