// 
// Helpers.swift
// Github-Profile
//
// Created by Marcos González on 2021.
// 
//

import Foundation

public func DLog(_ message: String, function: String = #function, line: Int = #line) {
  #if DEBUG
  print(" 🔎 \(function):\(line) - \(message)")
  #endif
}
