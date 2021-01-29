//
//  RowView.swift
//  TestWatchAppSwiftUI
//
//  Created by Steven Lipton on 4/9/20.
//  Copyright © 2020 Steven Lipton. All rights reserved.
//

import SwiftUI

struct RowView: View {
  var menuItem: MenuItem
  @State private var zoom: Bool = false
  var body: some View {
    let size: CGFloat = 60
    VStack {
      HStack {
        let scale = zoom ? size : size / 2
        //Explore animation on zoom feature, toogle the image size when image ontap gesture
        Image(String(format:"%i_100w",menuItem.id))
          .resizable()
          .frame(
            width:scale,
            height:scale)
          .onTapGesture {
            zoom.toggle()
          }.animation(.interpolatingSpring(stiffness: 15, damping: 10))
          .scaledToFit()
          .clipShape(Circle())
        Text(menuItem.name)
          .font(.caption).fontWeight(.bold)
          .minimumScaleFactor(0.85)
        Spacer()
      }
      RatingsView(ratings: .constant(menuItem.rating))
        .frame(height:12)
        .padding()
    }
  }
}

struct RowView_Previews: PreviewProvider {
  static var previews: some View {
    RowView(menuItem: MenuModel.menu[1])
  }
}
