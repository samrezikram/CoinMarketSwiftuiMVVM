//
//  ContentView.swift
//  CoinMarketSwiftuiMVVM
//
//  Created by Samrez Ikram on 16/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      CoinsListView(viewModel: CoinMarketListViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
