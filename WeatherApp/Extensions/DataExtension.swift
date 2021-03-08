//
//  DataExtension.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation

extension Data {
    func decode<T:Decodable> (as Type : T.Type = T.self,
                                handleOn  resultQueue :  DispatchQueue = .main,
                                handler : @escaping (Result<T, Error>)->Void)
    {
        let queue = DispatchQueue(label: "com.myapp.data.json.decode")
        let decoder = JSONDecoder()
        queue.async {
            let result = Result {
                try decoder.decode(T.self, from: self)
            }
            resultQueue.async {
                handler(result)
            }
        }
    }
}
