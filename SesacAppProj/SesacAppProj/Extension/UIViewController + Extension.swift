//
//  UIViewController + Extension.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//

import UIKit

extension UIViewController {
    // 토스트 메세지
    func showToast(message : String,font : UIFont , width: CGFloat, height : CGFloat) {

        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - width/2, y: view.frame.size.height - 100, width: width, height: height))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        },
            completion: { Completed in
            toastLabel.removeFromSuperview()
        })
    }
}
