//
//  FileError.swift
//  WeatherApp
//
//  Created by Divesh Singh on 2/28/21.
//

import Foundation

enum FileError : Error {
    case invalidPath
    case invalidData
    case emptyFile
}
