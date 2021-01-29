//
//  ContentView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 04/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
        Text("Huli Pizza Company")
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          .foregroundColor(.green)
        Divider()
        PizzaOrderView()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
