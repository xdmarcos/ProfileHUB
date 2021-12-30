// 
// File.swift
// 
//
// Created by Marcos González on 2021.
// 
//

import UIKit

public extension UIImage {
	func hasSameData(_ image: UIImage?) -> Bool {
		self.pngData() == image?.pngData()
	}
}

public extension UIImageView {
	func loadImage(for item: ImageCacheItem, animated: Bool = false) {
		ImageCache.public.load(url: item.url as NSURL, item: item) { fetchedItem, newImage in
			if animated {
				UIView.transition(
					with: self,
					duration: 0.2,
					options: .transitionCrossDissolve,
					animations: {
						self.image = newImage ?? fetchedItem.placeHolderImage
				}, completion: nil)
			} else {
				self.image = newImage ?? fetchedItem.placeHolderImage
			}
		}
	}
	
	func loadImage(for item: ImageCacheItem, animated: Bool = false, completion: ((Result<ImageCacheItem, Error>) -> Void)?) {
		ImageCache.public.load(url: item.url as NSURL, item: item) { fetchedItem, image in
			guard let newImage = image else {
				completion?(.failure(ImageCacheError.failedToDownload))
				return
			}

			if !newImage.hasSameData(fetchedItem.image) {
				if animated {
					UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
						self.image = newImage
					}, completion: nil)
				} else {
					self.image = newImage
				}
			}

			item.image = newImage
			completion?(.success(item))
		}
	}

	func cancelImageLoad(_ url: URL) {
		ImageCache.public.cancelLoad(url as NSURL)
	}
}
