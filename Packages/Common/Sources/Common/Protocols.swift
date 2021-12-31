//
// File.swift
// 
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public protocol FlowCoordination: AnyObject {
	func start()
}

public protocol UserDefaultsHelperProtocol {
	var userDefaults: UserDefaults { get }
	func write<T: NSObject>(value: T, key: String)
	func read<T: NSObject>(key: String) -> T?
}
