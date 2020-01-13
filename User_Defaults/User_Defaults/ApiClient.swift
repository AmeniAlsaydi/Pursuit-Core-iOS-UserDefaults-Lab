//
//  ApiClient.swift
//  User_Defaults
//
//  Created by Amy Alsaydi on 1/13/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper

struct APIClient {
    static func getHoroscope(sign: String, completion: @escaping (Result<Horoscope, AppError>) -> ()) {
    let endpointURLString = "http://sandipbgt.com/theastrologer/api/horoscope/\(sign)/today"
        
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
        
    let request = URLRequest(url: url)
        
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        do {
          let horoscope = try JSONDecoder().decode(Horoscope.self, from: data)
          completion(.success(horoscope))
        } catch {
          completion(.failure(.decodingError(error)))
        }
      }
    }
  }
}
