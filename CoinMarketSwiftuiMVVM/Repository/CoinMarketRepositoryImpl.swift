//
//  PaybackRepositoryImpl.swift
//  WorldOfPAYBACKClean
//
//  Created by Samrez Ikram on 14/02/2023.
//

import Foundation
struct CoinMarketRepositoryImpl: CoinMarketRepository{
  
  var dataSource: CoinMarketDataSource
  
  func transactions() async throws -> [TransactionListItem] {
    let transactionItems = try await dataSource.transactions()
    return transactionItems.data.map { item in
      TransactionListItem(
        id: String(item.id),
        currencyName: item.name, symbol: item.symbol, usdValue: item.quote["USD"]?.price, changePercentIn1Hour: item.quote["USD"]?.price, changePercentIn24Hour: item.quote["USD"]?.percentChange24H, changePercentIn7Days: item.quote["USD"]?.percentChange7D)
    }
  }
  
}
