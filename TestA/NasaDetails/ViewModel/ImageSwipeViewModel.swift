//
//  ImageSwipeViewModel.swift
//  TestA
//
//  Created by vikas shankhdhar on 05/12/22.
//

import Foundation


protocol ImageSwipeViewModelProtocol {
    func articleAtIndex( completion: @escaping (NasaHomeModel) -> Void)
    func articleSwipeLeftAtIndex(completion: @escaping (Int) -> Void)
    func articleSwipeRightAtIndex(completion: @escaping (Int) -> Void)
    
}

class ImageSwipeViewModel: ImageSwipeViewModelProtocol {
    var filteredData: [NasaHomeModel]?
    var currentImage : Int = 0
    var selectedImage = 0
    init() {
    }
}

extension ImageSwipeViewModel {
    
    var itemIndex: Int {
        return  self.currentImage
    }
    
    var numberOfSections: Int {
        return  self.filteredData!.count
    }
    
    // Fetch particular item from dataSource
    func articleAtIndex(completion: @escaping (NasaHomeModel) -> Void) {
        if let article = self.filteredData?[currentImage] {
            completion(article)
        }
    }
    
    // Fetch particular item from dataSource @Swipeleft
    func articleSwipeLeftAtIndex(completion: @escaping (Int) -> Void) {
        if currentImage ==  numberOfSections - 1 {
            currentImage = 0
        }else{
            currentImage = currentImage + 1
        }
        completion(currentImage)
    }
    
    // Fetch particular item from dataSource @SwipeRight
    func articleSwipeRightAtIndex(completion: @escaping (Int) -> Void) {
        if currentImage == 0 {
            currentImage = numberOfSections - 1
        }else{
            currentImage -= 1
        }
        completion(currentImage)
    }
}
