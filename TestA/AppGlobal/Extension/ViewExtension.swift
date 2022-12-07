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
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.yellow.cgColor

    }
    public func setLineUI(){
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.yellow.cgColor

    }

    func setBorderRadius(borderWidth:CGFloat,borderColor:UIColor,cornerRadius:CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
