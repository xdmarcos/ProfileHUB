//
// KeyChain.swift
//
//
// Created by Marcos González on 2021.
//
//

import Foundation

public struct KeyChain {
	public static func string(forKey key: String) -> String? {
		KeychainWrapper.standard.string(forKey: key)
	}

	public static func bool(forKey key: String) -> Bool? {
		KeychainWrapper.standard.bool(forKey: key)
	}

	public static func integer(forKey key: String) -> Int? {
		KeychainWrapper.standard.integer(forKey: key)
	}

	public static func double(forKey key: String) -> Double? {
		KeychainWrapper.standard.double(forKey: key)
	}

	public static func data(forKey key: String) -> Data? {
		KeychainWrapper.standard.data(forKey: key)
	}

	public static func set(value: String, forKey key: String) {
		KeychainWrapper.standard.set(value, forKey: key)
	}

	public static func set(value: Bool, forKey key: String) {
		KeychainWrapper.standard.set(value, forKey: key)
	}

	public static func set(value: Int,forKey key: String) {
		KeychainWrapper.standard.set(value, forKey: key)
	}

	public static func set(value: Double, forKey key: String) {
		KeychainWrapper.standard.set(value, forKey: key)
	}

	public static func set(value: Data, forKey key: String) {
		KeychainWrapper.standard.set(value, forKey: key)
	}

	@discardableResult
	public static func removeValue(forKey: String) -> Bool {
		KeychainWrapper.standard.removeObject(forKey: forKey)
	}

	@discardableResult
	public static func removeAllKeys() -> Bool {
		KeychainWrapper.standard.removeAllKeys()
	}

	public static func cleanKeychain() {
		KeychainWrapper.wipeKeychain()
	}
}
