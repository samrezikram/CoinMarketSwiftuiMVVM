//
//  CoinMarketListState.swift
//  CoinMarketSwiftuiMVVM
//
//  Created by Samrez Ikram on 17/02/2023.
//

import Foundation
enum CoinMarketListState: Equatable {
  case initial
  case loading
  case results
  case empty
  case error
}

enum CoinMarketListEvent {
  case onAppear

  case retry
  case reload

  case didFetchResultsSuccessfully(_ results: [TransactionListItem])
  case didFetchResultsFailure(_ error: Error)
  case didFetchResultsEmpty

  case openCarDetail(_ car: TransactionListItem)
}
