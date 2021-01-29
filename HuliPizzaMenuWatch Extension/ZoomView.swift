//
//  ZoomView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 06/01/2021.
//

import SwiftUI

struct ZoomView: View {
  var displayImage:String
  @State var zoomWidth:CGFloat = 40
  var body: some View {
    let step: CGFloat = 100
    let minZoom: CGFloat = 40
    let maxZoom: CGFloat = 120
    VStack{
    Image(displayImage)
      .resizable()
      .scaledToFit()
      .frame(height:zoomWidth)
      .cornerRadius(zoomWidth > step ? 10 : zoomWidth * 0.15)
      .focusable()
      .digitalCrownRotation($zoomWidth,
                            from: minZoom,
                            through: maxZoom,
                            by: step,
                            sensitivity: .high,
                            isContinuous:false,
                            isHapticFeedbackEnabled: true)
      Spacer()
    }.animation(.interpolatingSpring(stiffness: 15, damping: 9))
  }
}

struct ZoomView_Previews: PreviewProvider {
  static var previews: some View {
    ZoomView(displayImage: "\(MenuModel.menu[2].id)_100w")
  }
}
