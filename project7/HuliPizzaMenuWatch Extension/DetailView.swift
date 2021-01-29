//
//  DetailView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 04/01/2021.
//

import SwiftUI
import ClockKit

struct DetailView: View {
  var item: MenuItem
  @Binding var selectedItem:Int!
  @Binding var selectedRow:Int?
  @State private var isRatingPresented: Bool = false
  @State private var displayImage: Bool = false

  func resetTimeLine() {
    //update current time, now defined in complicationsExtension
    now = Date()
    //grab the singleton complication server
    let server = CLKComplicationServer.sharedInstance()
    //grab all active complications for our watchOS app and reload their timelines
    if let activeComplications = server.activeComplications {
     _ = activeComplications.map {
        server.reloadTimeline(for: $0)
      }
    }
  }
  
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Text(item.name)
            .fontWeight(.heavy)
          Spacer()
        }
        Image("\(item.id)_100w")
          .onTapGesture{
            self.displayImage.toggle()
            WKInterfaceDevice.current().play(.click)
          }.sheet(isPresented: self.$displayImage,
                  content: {  ZoomView(displayImage: "\(item.id)_100w")
                  })
          .cornerRadius(10)
        //Best practice for small screen, important things first
        OrderButton(action: {
          //Launch complecations
          resetTimeLine()
          //add haptic
          WKInterfaceDevice.current().play(.success)
          self.selectedItem = self.item.id
          self.selectedRow = nil //pop off the stack from navigation
        })
        Text(item.description)
//        NavigationLink(
//          // bind the selected details
//          destination: RatingsDetailView(item: item)
//        ){
//          Text("Reviews")
//        }
        Button(action: {
          self.isRatingPresented = true //show
        }, label: {
          Text("Reviews")
        }).sheet(
            isPresented: $isRatingPresented,
            content: {
              RatingsDetailView(isRatingPresented: $isRatingPresented, item: item)
        })
      }.navigationBarTitle(item.name)
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(item:MenuModel.menu[2],
               selectedItem:.constant(2),
               selectedRow: .constant(2)
    )
  }
}
