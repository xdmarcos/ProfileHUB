//
//  Extensions.swift
//  CommonUI
//
//  Created by xdmgzdev on 25/03/2021.
//

import UIKit

public extension UIImage {
	enum NavigationBar {
		static var back: UIImage? { UIImage(named: Identifiers.navBarBackButtonImage) }
	}
}

public extension UIView {
	func addSubviewForAutolayout(subview: UIView) {
		subview.translatesAutoresizingMaskIntoConstraints = false
		addSubview(subview)
	}

	func addSubviewsForAutolayout(subviews: [UIView]) {
		for subview in subviews {
			subview.translatesAutoresizingMaskIntoConstraints = false
			addSubview(subview)
		}
	}
}

public extension UIColor {
	convenience init(hex3: UInt16, alpha: CGFloat = 1) {
		let divisor = CGFloat(15)
		let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
		let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
		let blue    = CGFloat( hex3 & 0x00F      ) / divisor
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	convenience init(hex4: UInt16) {
		let divisor = CGFloat(15)
		let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
		let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
		let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
		let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	convenience init(hex6: UInt64, alpha: CGFloat = 1) {
		let divisor = CGFloat(255)
		let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
		let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
		let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	convenience init(hex8: UInt64) {
		let divisor = CGFloat(255)
		let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
		let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
		let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
		let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	convenience init?(_ rgba: String) {
		guard rgba.hasPrefix("#") else { return nil }

		let hexString: String = String(rgba[String.Index(utf16Offset: 1, in: rgba)...])
		var hexValue:  UInt64 = 0

		guard Scanner(string: hexString).scanHexInt64(&hexValue) else { return nil }

		switch (hexString.count) {
		case 3:
			self.init(hex3: UInt16(hexValue))
		case 4:
			self.init(hex4: UInt16(hexValue))
		case 6:
			self.init(hex6: hexValue)
		case 8:
			self.init(hex8: hexValue)
		default:
			return nil
		}
	}
}
