//
//  UIImageExtn.swift
//  TestCollection
//
//  Created by vikas shankhdhar on 22/04/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func cacheImageForCollection(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        if(URLString.isValidForUrl())
        {
            if let url = URL(string: URLString) {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.image = placeHolder
                        }
                        return
                    }
                        if let data = data {
                            if let downloadedImage = UIImage(data: data) {
                                imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                                DispatchQueue.main.async {
                                self.image = downloadedImage
                            }
                        }
                    }
                }).resume()
            }
        }
        else{
             DispatchQueue.main.async {
                    self.image = placeHolder
                }
        }
    }
}





