//
//  ResourceData.swift
//  TestA
//
//  Created by vikas shankhdhar on 07/12/22.
//

import Foundation

struct ResourceData<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data? = nil
}

extension ResourceData {
    init(urlString: String, queryItems:[URLQueryItem]? = nil) {
        var urlComps = URLComponents(string: urlString)
        if let items = queryItems {
            urlComps?.queryItems = items
        }
        guard let url = urlComps?.url else { fatalError("URL is incorrect") }
        self.url = url
    }
}
