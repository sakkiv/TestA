//
//  DeviceExtn.swift
//  TestCollection
//
//  Created by vikas shankhdhar on 22/04/21.
//

import Foundation
import UIKit

extension UIApplication {
    public var isLandscape: Bool {
        get {
            return self.statusBarOrientation.isLandscape
        }
    }
}
public extension UIDevice {
    var isIPad: Bool {
        return self.userInterfaceIdiom == .pad
    }
}
