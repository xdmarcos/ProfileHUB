//
//  Helpers.swift
//  Common
//
//  Created by xdmgzdev on 25/03/2021.
//

import Foundation

public func DLog(_ message: String, function: String = #function, line: Int = #line) {
  #if DEBUG
  print(" 🔎 \(function):\(line) - \(message)")
  #endif
}

public struct UserDefaultsHelper: UserDefaultsHelperProtocol {
	public init() {}
	public func write<T>(value: T, key: String) where T : NSObject {
		UserDefaults.standard.set(value, forKey: key)
	}

	public func read<T>(key: String) -> T? where T : NSObject {
		guard let value = UserDefaults.standard.object(forKey: key) as? T else {
			return nil
		}
		return value
	}
}
