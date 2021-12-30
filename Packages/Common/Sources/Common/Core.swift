//
//  Core.swift
//  Common
//
//  Created by xdmgzdev on 29/03/2021.
//

import Foundation

class Binder<T> {
  typealias Listener = (T) -> Void

  var listener: Listener?
  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
