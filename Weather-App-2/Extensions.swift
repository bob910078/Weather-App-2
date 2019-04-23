//
//  Extensions.swift
//  Weather-App-2
//
//  Created by Bob Chang on 2019/4/23.
//  Copyright © 2019 mitchell hudson. All rights reserved.
//

import UIKit


typealias Closure = () -> Void
typealias AlertAction = (UIAlertAction) -> Void


extension UIViewController {
    
    func basicAlert(title t: String?, message m: String? = nil, okHandler: AlertAction? = nil, completeHandler: Closure? = nil) {
        let okButtonTitle: String = "OK"
        let alert = UIAlertController(title: t, message: m, preferredStyle: .alert)
        let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: okHandler)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: completeHandler)
    }
    
}

extension UIView {
    
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
