//
//  RatingsView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 04/01/2021.
//

import SwiftUI

struct RatingsView: View {
  @Binding var ratings: Int
  var maxRatings: Int = 6
  var body: some View {
    HStack {
      ForEach(1...maxRatings,id:\.self) { star in

        Image(systemName: star > self.ratings ?
                "star": "star.fill")
          .resizable().scaledToFit()
          .foregroundColor(.yellow)
      }
    }
  }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
      RatingsView(ratings: .constant(3))
    }
}
