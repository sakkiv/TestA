//
//  ToastView.swift
//  TestCollection
//
//  Created by vikas shankhdhar on 23/04/21.
//

import Foundation
import UIKit

class ToastClass {
     class func toastView(messsage : String, view: UIView ){
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300,  height : 55))
        toastLabel.backgroundColor = UIColor.clear.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
         toastLabel.numberOfLines = 0
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = messsage
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
         toastLabel.font =  .subHeaderRegularFont(ofSize: 14)
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 0.9, delay: 0.9, options: UIView.AnimationOptions.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            
        })
    }
}
