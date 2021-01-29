//
//  RatingsDetailView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 05/01/2021.
//

import SwiftUI

struct RatingsDetailView: View {
  //control via the crown
  @State var myRating:Float = 0
  @Binding var isRatingPresented: Bool
  var item: MenuItem
  var body: some View {
    VStack{
      Text(item.name).fontWeight(.bold)
      RatingsView(ratings: .constant(Int(myRating)))
      Image(String(format:"%i_100w",item.id))
        .resizable()
        .frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .scaledToFit()
        .cornerRadius(10)
      Button(action: {
        self.isRatingPresented = false
      }, label: { Text("Ok")})
    }
    .navigationBarTitle(item.name)
    .focusable(true)
    .digitalCrownRotation(
      $myRating,
      from: 0,
      through: 6,
      by: 1,
      sensitivity: .low,
      isContinuous: false,
      isHapticFeedbackEnabled: true)
  }
}

struct RatingsDetailView_Previews: PreviewProvider {
  static var previews: some View {
    RatingsDetailView(isRatingPresented: .constant(true), item: MenuModel.menu[2])
  }
}
