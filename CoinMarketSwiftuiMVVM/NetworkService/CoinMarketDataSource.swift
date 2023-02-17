//
//  PaybackDataSource.swift
//  WorldOfPAYBACKClean
//
//  Created by Samrez Ikram on 14/02/2023.
//

import Foundation

protocol CoinMarketDataSource{
    func transactions() async throws -> CoinMarket<CoinMarketData>
}
