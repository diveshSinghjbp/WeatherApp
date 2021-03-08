//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation
typealias NetworkResult = (Data?, Error?) -> Void
class NetworkManager {
    private let session: NetworkSession

    init(session: NetworkSession) {
        self.session = session
    }

    func loadData(from url: URL,
                  completionHandler: @escaping NetworkResult) {
        session.loadData(from: url) { data, error in
            completionHandler(data,error)
        }
    }
}
