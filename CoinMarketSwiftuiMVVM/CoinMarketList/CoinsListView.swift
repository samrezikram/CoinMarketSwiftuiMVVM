//
//  CoinsListView.swift
//  B2BrokerCryptoAssessment
//
//  Created by Samrez Ikram on 28/12/2022.
//

import Combine
import SwiftUI

struct CoinsListView: View {
    @ObservedObject var viewModel: CoinMarketListViewModel
        
    var body: some View {
        NavigationView {
          content
            .navigationBarTitle("Coin Market")
        }
        .onAppear { self.viewModel.send(event: .onAppear) }
    }
    
    private var content: some View {
      VStack {
        switch viewModel.state {
        case .initial:
          Text("init")
        case .loading:
          Spinner(isAnimating: true, style: .large)
        case .results:
          list(of: viewModel.data)
        case .empty:
          Text("EMpty")
        case .error:
          Text("error")
        }
      }.onAppear {
        viewModel.send(event: .onAppear)
      }
    }
    
  private func list(of coinMarkets: [TransactionListItem]) -> some View {
    @State var showSheet = true

    return List {
      ForEach (coinMarkets) { coinMarket in
        CoinMarketViewCell(coinMarket: coinMarket)
          .padding()
      }.listRowSeparator(.visible, edges: .all)
    }
//    .refreshable {
//      self.viewModel.send(event: .onRefreshCrypto)
//    }
  }
}

struct CoinMarketViewCell: View {
  let coinMarket: TransactionListItem

  
  var body: some View {
    let isIncreasingInLastOneHour = coinMarket.changePercentIn1Hour > 0
    let isIncreasingInLastTwentyFourHour = coinMarket.changePercentIn24Hour > 0
    let isIncreasingInLastSevenDays = coinMarket.changePercentIn7Days > 0

    HStack(alignment: .top) {
      VStack(alignment: .leading) {
        HStack {
          Text(coinMarket.currencyName).bold().font(.system(size: 11))
        }
        Text(coinMarket.usdValue).bold().font(.system(size: 11))
        
        VStack(alignment: .center) {
          HStack {

            Image(systemName: isIncreasingInLastOneHour ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill").foregroundColor(isIncreasingInLastOneHour ? .green : .red)
            Text(String(coinMarket.changePercentIn1Hour) + "% (1h)").font(.system(size: 11)).frame(minWidth: 50, maxWidth: 70, alignment: .leading)
          
            Image(systemName: isIncreasingInLastTwentyFourHour ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill").foregroundColor(isIncreasingInLastTwentyFourHour ? .green : .red).frame(width: 5, height: 5)
            Text(String(coinMarket.changePercentIn24Hour) + "% (24h)").font(.system(size: 11)).frame(minWidth: 70, maxWidth: 70, alignment: .leading)
            
            Image(systemName: isIncreasingInLastSevenDays ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill").foregroundColor(isIncreasingInLastSevenDays ? .green : .red)
            Text(String(coinMarket.changePercentIn7Days) + "% (7d)").font(.system(size: 11)).frame(minWidth: 50, maxWidth: 70, alignment: .leading)
          }.foregroundColor(.blue)
        }
      }

    }
    
  }

}
