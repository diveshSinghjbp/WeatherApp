//
//  NetworkSession.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation
protocol NetworkSession {
    func loadData(from url: URL, then completionHandler : @escaping (Data?, Error?)-> Void)
}
extension URLSession : NetworkSession {
    func loadData(from url: URL, then completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data,error)
        }
        task.resume()
    }
}
class NetworkSessionMock : NetworkSession {
    var error : Error?
    var data : Data?
    func loadData(from url: URL, then completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
// We create a partial mock by subclassing the original class
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?

    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
