//
//  ViewExtension.swift
//  TestA
//
//  Created by vikas shankhdhar on 07/12/22.
//

import Foundation
import UIKit

extension UIView {
    public func setButtonUI(){
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.yellow.cgColor

    }
    public func setLineUI(){
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.yellow.cgColor

    }
}
