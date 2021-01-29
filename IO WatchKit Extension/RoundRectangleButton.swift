//
//  RoundRectangleButton.swift
//  FocalBreathing WatchKit Extension
//
//  Created by Ashlee Muscroft on 26/01/2021.
//

import SwiftUI

struct RoundRectangleButton: View {
    var title:String = "Button"
    var action: () -> Void
    var fillColor:Color  = Color("ComponentGrey")
    var body: some View {
        Button(action: {
            action()
        }, label: { 
            Text(title)
                .font(.headline )
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 5.0, style: .continuous).fill(fillColor))
        }).buttonStyle(PlainButtonStyle())
    }
}
struct RoundRectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundRectangleButton(title: "start",action: {})
    }
}
