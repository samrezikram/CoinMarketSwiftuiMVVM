//
//  CoinMarketListViewModel.swift
//  CoinMarketSwiftuiMVVM
//
//  Created by Samrez Ikram on 17/02/2023.
//

import Foundation
class CoinMarketListViewModel: StateMachine<CoinMarketListState, CoinMarketListEvent> {

  // MARK: Lifecycle
  var getCoinMarketUseCase = CoinMarketUseCase(repo: CoinMarketRepositoryImpl(dataSource: CoinMarketServiceImpl()))

  init() {
    super.init(.initial)
  }

  // MARK: Internal

  var data: [TransactionListItem] = []

  
  
  override func handleEvent(_ event: CoinMarketListEvent) -> CoinMarketListState? {
    switch(state, event) {
    case (.initial, .onAppear):
      fetchData()
      return .loading
    
    case (.loading, .onAppear):
      break
    case (.loading, .didFetchResultsSuccessfully(let results)):
        data = results
        return .results
    
    case (.loading, .didFetchResultsFailure(let error)):
        stateError = error
        return .error
    default:
      fatalError("Event not handled...")
    }
    
    return nil
  }
  
//  override func handleEvent(_ event: CoinMarketListEvent) -> CoinMarketListState? {
//    switch(state, event) {
//    case (.initial, .onAppear):
//      fetchData()
//      return .loading
//
//    case (.loading, .didFetchResultsSuccessfully(let results)),
//         (.results, .didFetchResultsSuccessfully(let results)):
//      return .results
//
//    case (.loading, .didFetchResultsFailure(let error)):
//      stateError = error
//      return .error
//
//    case (.loading, .didFetchResultsEmpty):
//      return .empty
//
//    case (.loading, .onAppear):
//
//
//    case (.results, .didFetchResultsEmpty):
//      break // Don't change the state to empty as we have some results to show to the user.
//
//    case (.results, .reload):
//      break
//
//    case
//      (.empty, .retry),
//      (.error, .retry):
//      fetchData()
//      return .loading
//
//    default:
//      fatalError("Event not handled...")
//    }
//
//    return nil
//  }

  override func handleStateUpdate(_ oldState: CoinMarketListState, new newState: CoinMarketListState) {
    switch(oldState, newState) {
    case (.initial, .loading):
      break
    case (.loading, .results):
      break
    case (.loading, .empty):
      data = []
      stateError = nil
    case (.error, .loading):
      stateError = nil
    case
      (.loading, .error),
      (.empty, .loading):
      data = []
    default:
      fatalError("You lended in a misterious place... Coming from \(oldState) and trying to get to \(newState)")
    }
  }

  // MARK: Private
  private func fetchData() {
    Task {
      let result = await getCoinMarketUseCase.execute()
      switch result {
      case .success(let transactionItems):
        send(event: .didFetchResultsSuccessfully(transactionItems))
        
      case .failure(let error):
        send(event: .didFetchResultsFailure(error))
      }

    }
  }

}
