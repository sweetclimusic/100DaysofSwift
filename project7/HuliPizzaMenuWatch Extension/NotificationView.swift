//
//  NotificationView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 04/01/2021.
//

import SwiftUI

struct NotificationView: View {
  //binding enviornment variable
  var bodyText:String = ""
  @State var pizzaId: Int = 0 //default to margaritta
    var body: some View {
      PizzaNotificationView(text: bodyText,id:$pizzaId)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
