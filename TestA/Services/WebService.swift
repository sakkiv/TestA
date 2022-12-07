//
//  WebService.swift
//  MVVM-2-MovieApp
//
//  Created by Can Babaoğlu on 4.10.2022.
//
import Foundation

protocol ServiceProtocol {
    func nasaData(completion: @escaping (Result<[NasaHomeModel]?,Error>) -> Void)
}

final class Services: ServiceProtocol {
    func nasaData(completion: @escaping (Result<[NasaHomeModel]?,Error>) -> Void) {
        ServiceManager.shared.load(resource: NasaHomeModel.allFor()) { result in
            switch result {
                case .success(let ticketList):
                completion(.success(ticketList))
                    break
                case .failure((let error)):
                completion(.failure(error))
                    break
            }
        }
    }
  }

extension NasaHomeModel {
   static var sourcesURL = Domain.dev
    static func allFor() -> ResourceData<NasaHomeModel> {
        return ResourceData<NasaHomeModel>.init(urlString: sourcesURL, queryItems: nil)
    }
}
