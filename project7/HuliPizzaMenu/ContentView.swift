//
//  ContentView.swift
//  HuliPizzaMenu
//
//  Created by Steven Lipton on 7/25/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Huli Pizza Company")
                .font(.headline)
            PizzaOrderView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
