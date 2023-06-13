//
//  UIViewController+Extensions.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import Foundation
import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        return ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.top ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
