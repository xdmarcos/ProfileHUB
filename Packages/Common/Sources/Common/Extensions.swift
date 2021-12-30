//
//  Extensions.swift
//  Common
//
//  Created by xdmgzdev on 24/03/2021.
//

import Foundation

public extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

public extension String {
  /// Fetches a localised String Arguments
  var localized: String {
    NSLocalizedString(self, comment: "")
  }

  /// Fetches a localised String Arguments
  ///
  /// - Parameter arguments: parameters to be added in a string
  /// - Returns: localized string
  func localized(with arguments: [CVarArg]) -> String {
    String(format: localized, locale: Locale.current, arguments: arguments)
  }

  func toDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"

    return dateFormatter.date(from: self)
  }
}

public extension Date {
  func toStringShort() -> String? {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.dateStyle = .short

    return formatter.string(from: self)
  }

  func toStringMedium() -> String? {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.dateStyle = .medium

    return formatter.string(from: self)
  }

  func toStringLong() -> String? {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.dateStyle = .long

    return formatter.string(from: self)
  }

  func toStringFull() -> String? {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.dateStyle = .full

    return formatter.string(from: self)
  }
}
