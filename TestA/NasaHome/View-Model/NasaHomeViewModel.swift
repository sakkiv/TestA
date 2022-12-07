//
//  EmployeeTableViewDataSource.swift
//  MVVM_New
//
//  Created by Abhilash Mathur on 20/05/20.
//  Copyright © 2020 Abhilash Mathur. All rights reserved.
//

import Foundation

protocol NasaHomeProtocol {
    func fetchNasaData(completion: @escaping () -> Void)
}

class NasaHomeDataSource: NasaHomeProtocol {
    
    var service: ServiceProtocol?
    var articles: [NasaHomeModel]?
    var sortedArticles: [NasaHomeModel]?
    var onErrorHandling : ((String?) -> Void)?
    var onSucessFullLoading : ((Bool?) -> Void)?

    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchNasaData(completion: @escaping () -> Void){
        guard let service = service else {
            self.onErrorHandling?(Constants.AlertMessages.NoDataFound)
            return
        }
        service.nasaData{ response  in
            switch(response) {
            case .success(let res):
                guard let response = res else {
                    self.onErrorHandling?(Constants.AlertMessages.NoDataFound)
                    return
                }
                self.articles = response
                self.onSucessFullLoading?(true)
                break;
            case .failure(let error):
                self.onErrorHandling?(error.localizedDescription)
                break
            }
        }
    }
}

extension NasaHomeDataSource {
    
    var numberOfSections: Int {
        if let nasaArcticles = self.sortedArticles {
            return  nasaArcticles.count
        }
        return 0
    }
    
    func articleAtIndex(_ index: Int) -> NasaHomeModel {
        let article = self.sortedArticles?[index]
        return article!
    }
    
    func sortedData() {
        let sortedUsers = articles?.sorted {
            $0.date! > $1.date!
        }
        sortedArticles = sortedUsers
    }
}



