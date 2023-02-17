//
//  TransactionListItem.swift
//  WorldOfPAYBACKClean
//
//  Created by Samrez Ikram on 14/02/2023.
//

import Foundation
struct TransactionListItem: Identifiable, Hashable {
  let id: String
  let currencyName: String
  let usdValue: String
  let changePercentIn1Hour: Double
  let changePercentIn24Hour: Double
  let changePercentIn7Days: Double


  
  init(coinMarketStat: CoinMarketData) {
    id = String(coinMarketStat.id) + UUID().uuidString
    currencyName = coinMarketStat.name + " (\(coinMarketStat.symbol))"
    usdValue = "\(coinMarketStat.quote["USD"]?.price.rounded(toPlaces: 5) ?? 1.69) USD"
    changePercentIn1Hour = (coinMarketStat.quote["USD"]?.percentChange1H ?? 1.69).rounded(toPlaces: 2)
    changePercentIn24Hour = (coinMarketStat.quote["USD"]?.percentChange24H ?? 1.69).rounded(toPlaces: 2)
    changePercentIn7Days = (coinMarketStat.quote["USD"]?.percentChange7D ?? 1.69).rounded(toPlaces: 2)
  }
  
  init(id: String, currencyName: String, symbol: String, usdValue: Double?, changePercentIn1Hour: Double?, changePercentIn24Hour: Double?, changePercentIn7Days: Double? ) {
    self.id = String(id) + UUID().uuidString
    self.currencyName = currencyName + " \(symbol)"
    self.usdValue = "\(usdValue?.rounded(toPlaces: 5) ?? 1.69) USD"
    self.changePercentIn1Hour = changePercentIn1Hour?.rounded(toPlaces: 2) ?? 1.69
    self.changePercentIn24Hour = changePercentIn24Hour?.rounded(toPlaces: 2) ?? 1.69
    self.changePercentIn7Days = changePercentIn7Days?.rounded(toPlaces: 2) ?? 1.69
  }

  static func == (lhs: TransactionListItem, rhs: TransactionListItem) -> Bool {
    return lhs.id == rhs.id &&
    lhs.currencyName == rhs.currencyName &&
    lhs.usdValue == rhs.usdValue &&
    lhs.changePercentIn1Hour == rhs.changePercentIn1Hour &&
    lhs.changePercentIn24Hour == rhs.changePercentIn24Hour &&
    lhs.changePercentIn7Days == rhs.changePercentIn7Days
  }
}
