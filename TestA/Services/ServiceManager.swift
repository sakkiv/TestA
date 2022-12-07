//
//  ServiceManager.swift
//  MVVM-2-MovieApp
//
//  Created by Can Babaoğlu on 4.10.2022.
//


// MARK: ~ Service Manager
import Foundation

final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    func load<T>(resource: ResourceData<T>, completion: @escaping (Result<[T], Error>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.timeoutInterval = 60 // or what you want
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let data = data else {
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
