//
//  ArticView.swift
//  FocalBreathing WatchKit Extension
//
//  Created by Ashlee Muscroft on 26/01/2021.
//

import SwiftUI

struct SessionView: View {
    private var start = NSLocalizedString("start", comment: "the button users click to start the breathing exercise.")
    private var title = NSLocalizedString("artic_title", comment: "title of the selected workout")
    private var description =
        NSLocalizedString("artic_description", comment: "detail description of the current breathing exercise.")
    var body: some View {
        VStack(alignment:.leading){
            let mint = UIColor(named:"Mint")!
            HStack{
                Text(title).font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName:"face.smiling.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(alignment:.trailing)
                    .padding(.trailing)
                    .foregroundColor(Color(mint))

            }.frame( alignment: .topLeading)
            ScrollView{
                Text(description).font(.caption)
            }
            RoundRectangleButton(title: start, action: {})
            Spacer()
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
