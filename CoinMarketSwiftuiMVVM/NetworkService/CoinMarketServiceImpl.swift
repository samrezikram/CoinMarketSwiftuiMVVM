//
//  PaybackService.swift
//  WorldOfPAYBACK
//
//  Created by Samrez Ikram on 09/02/2023.
//
import Foundation
import Combine

enum APIServiceError: Error{
    case badUrl, fileNotFound, requestError, decodingError, statusNotOK
}

struct CoinMarketServiceImpl: CoinMarketDataSource {

  func transactions() async throws -> CoinMarket<CoinMarketData> {
    guard let url = URL(string: "\(Constants.Network.API.BASE_URL)v1/cryptocurrency/listings/latest") else{
      throw APIServiceError.badUrl
    }
    
    var request = URLRequest(url: url)
    request.setValue(Constants.Network.API.apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
            
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw APIServiceError.statusNotOK
    }
  
    guard let result = try? JSONDecoder().decode(CoinMarket<CoinMarketData>.self, from: data) else {
        throw APIServiceError.decodingError
    }
    return result
  }
}


