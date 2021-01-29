//
//  PizzaNotificationView.swift
//  SwiftUINotifications WatchKit Extension
//
//  Created by Steven Lipton on 8/2/20.
//

import SwiftUI

struct PizzaNotificationView: View {
    var text:String! = nil
    @Binding var id:Int
    var menu = MenuModel.menu
    var body: some View {
            ZStack{
                Image("\(id)_100w")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(5)
                VStack {
                    if text != nil {Text(text)}
                    Text(menu[id].name).font(.caption)
                }
                .padding()
                .background(Color(white: 0.4,opacity:0.6))
                .cornerRadius(5.0)
            }
    }//body
}

struct PizzaNotificationView_Previews: PreviewProvider {
    static var previews: some View {
      PizzaNotificationView(id: .constant(0))
    }
}
