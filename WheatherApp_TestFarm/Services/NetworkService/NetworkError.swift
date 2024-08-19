//
//  NetworkErrors.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidApiKey
    case invalidURL
    case serverUnavailable
    case parsingError
}
