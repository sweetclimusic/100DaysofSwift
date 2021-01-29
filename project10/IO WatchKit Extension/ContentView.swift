//
//  ContentView.swift
//  FocalBreathing WatchKit Extension
//
//  Created by Ashlee Muscroft on 24/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            RelaxView()
            EnduranceView()
            ArticView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
