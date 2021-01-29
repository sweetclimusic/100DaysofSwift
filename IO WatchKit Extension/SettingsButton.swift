//
//  SettingsButtonView.swift
//  FocalBreathing WatchKit Extension
//
//  Created by Ashlee Muscroft on 27/01/2021.
//

import SwiftUI

struct SettingsButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            #warning ("TODO: add scale base on geometryreader side over magic numbers")
            HStack{
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(maxWidth: 25,maxHeight: 25)
                        .scaledToFit()
                        .foregroundColor(.tolGreen)
            }.frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.componentGrey)
            .clipShape(Circle())
        }).buttonStyle(PlainButtonStyle())

    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(action: {})
    }
}
