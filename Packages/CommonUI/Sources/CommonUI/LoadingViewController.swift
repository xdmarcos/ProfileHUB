//
// LoadingViewController.swift
// CommonUI
//
// Created by Marcos González on 2021.
// 
//

import UIKit

public class LoadingViewController: UIViewController {
	private enum ViewTraits {
		static let backgroundAlpha: CGFloat = 0.5
		static let blurAlpha: CGFloat = 0.8
	}
	var loadingActivityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.style = .large
		indicator.color = .white
		indicator.autoresizingMask = [
			.flexibleLeftMargin, .flexibleRightMargin,
			.flexibleTopMargin, .flexibleBottomMargin
		]

		return indicator
	}()

	var blurEffectView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.alpha = ViewTraits.blurAlpha
		blurEffectView.autoresizingMask = [
			.flexibleWidth, .flexibleHeight
		]

		return blurEffectView
	}()

	public override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor.black.withAlphaComponent(ViewTraits.backgroundAlpha)

		blurEffectView.frame = view.bounds
		view.insertSubview(blurEffectView, at: 0)

		loadingActivityIndicator.center = view.center
		view.addSubview(loadingActivityIndicator)
	}

	public func startLoading() {
		loadingActivityIndicator.startAnimating()
	}

	public func stopLoading() {
		loadingActivityIndicator.stopAnimating()
	}
}
