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
