//
//  MyCollectionViewCell.swift
//  TestCollection
//
//  Created by vikas shankhdhar on 22/04/21.
//

import Foundation
import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet public weak var backview: UIView!
    @IBOutlet public weak var idbackView: UIView!
    @IBOutlet public weak var profileImage: UIImageView!
    @IBOutlet public weak var datelabel: UILabel!
    @IBOutlet public weak var countLabel: UILabel!
    
    var movieItem: NasaHomeModel? {
        didSet {
            if let model = movieItem {
                if let idVal = model.service_version {
                    self.countLabel.text = idVal
                }
                if let ln = model.date{
                    self.datelabel.text = ln
                }
                if let url = model.url {
                    DispatchQueue.main.async {
                    self.profileImage.cacheImageForCollection(url, placeHolder: UIImage(named: "placeholder"))
                    }
                    self.profileImage.contentMode = .scaleToFill
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        profileImage.backgroundColor = .clear

        profileImage.clipsToBounds = true

        idbackView.backgroundColor = .black
        countLabel.textColor = .white
        datelabel.font =  .subHeaderBoldFont(ofSize: 16)
        countLabel.font =  .subHeaderBoldFont(ofSize: 12)
        
        
        
        profileImage.setBorderRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 15)
        backview.setBorderRadius(borderWidth: 1, borderColor: .lightGray, cornerRadius: 10)
        idbackView.setBorderRadius(borderWidth: 0, borderColor: .clear, cornerRadius: idbackView.frame.height / 2)
    }
}



