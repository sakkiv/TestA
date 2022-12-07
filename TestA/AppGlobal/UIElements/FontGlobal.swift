//
//  FontGlobal.swift
//  TestA
//
//  Created by vikas shankhdhar on 05/12/22.
//

import Foundation
import UIKit

extension UIFont {
     static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    static func mainHeaderFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Arial Hebrew Bold ", size: size)
    }
    
    static func subHeaderBoldFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Arial Hebrew Bold", size: size)
    }
    
    static func subHeaderRegularFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Arial Hebrew", size: size)
    }
}
