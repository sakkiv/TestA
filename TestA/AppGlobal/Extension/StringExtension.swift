//
//  StrinfExtn.swift
//  TestCollection
//
//  Created by vikas shankhdhar on 23/04/21.
//

import Foundation
import UIKit

extension String{
    func isValidForUrl()->Bool{
        if(self.hasPrefix("http") || self.hasPrefix("https")){
            return true
        }
        return false
    }
}



