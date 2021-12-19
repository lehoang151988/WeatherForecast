//
//  UIView+Extension.swift
//  WeatherForecast
//
//  Created by Hoang Le on 17/12/2021.
//

import UIKit
import SnapKit

extension UITableView {
    func setLoading(visible: Bool) {
        var loadingImageView = self.viewWithTag(121)
        if visible {
            if loadingImageView == nil {
                let tintableImage = UIImage(named: "loading")?.withRenderingMode(.alwaysTemplate)
                let localLoadingImageView = UIImageView(image:tintableImage)
                localLoadingImageView.tag = 121
                localLoadingImageView.alpha = 0
                localLoadingImageView.tintColor = UIColor.white
                self.addSubview(localLoadingImageView)
                localLoadingImageView.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.size.equalTo(70)
                }
                localLoadingImageView.rotate()
                loadingImageView = localLoadingImageView
                UIView.animate(withDuration: 0.3) {
                    localLoadingImageView.alpha = 1
                    self.layoutSubviews()
                }
                self.isUserInteractionEnabled = false
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                loadingImageView?.alpha = 0
                self.layoutSubviews()
            }) { (_) in
                loadingImageView?.removeFromSuperview()
                loadingImageView = nil
                self.isUserInteractionEnabled = true
            }
        }
    }
}

extension UIImageView {
    func rotate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue =  Double.pi * 2.0
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: "spin")
    }
}
