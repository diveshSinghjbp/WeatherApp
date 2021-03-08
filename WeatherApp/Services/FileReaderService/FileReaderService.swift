//
//  FileReader.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation

protocol LocationListService {
    
}
class FileReaderService {
    func readJsonFile<T : Decodable>(fileName resourceName:  String,
                                     withExtension ext : String,
                                     ofType type : T.Type,
                                     onResultQueue  resultQueue : DispatchQueue = .main,
                                     then completionHandler : @escaping (Result<T, Error>)->Void) throws  {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: ext) else{
            throw FileError.invalidPath
        }
        
        let data = try Data(contentsOf: url)
        if data.count == 0 {
            throw FileError.emptyFile
        }
        data.decode(as: T.self, handleOn: resultQueue) { (result) in
            completionHandler(result)
        }
        
    }
}
