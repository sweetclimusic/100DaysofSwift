//
//  PizzaOrderView.swift
//  PizzaOrder
//
//  Created by Steven Lipton on 4/21/20.
//  Copyright © 2020 Steven Lipton. All rights reserved.
//

import SwiftUI

struct PizzaOrderView: View {
    @State var selectedItem:Int!
    @State var selectedRow:Int!
    var menuItems = MenuModel.menu
    var body: some View {
        GeometryReader{ geometry in
          VStack {
           Text(self.selectedItem != nil ? MenuModel.menu[self.selectedItem!].name :"Pick a Pizza")
                  .font(.body)
            List{
                ForEach(self.menuItems){ item in
                    NavigationLink(
                      // bind the selected details
                      destination: DetailView(
                        item: item,
                        selectedItem: self.$selectedItem,
                        selectedRow: self.$selectedRow),
                        tag:item.id,
                        selection: self.$selectedRow
                      ){
                      RowView(menuItem: item)//animation modifiers
                        .animation(
                          .easeInOut(duration:0.75)
                        )
                    }
                    .listRowPlatterColor(
                      Color(
                        red: 0,
                        green: self.selectedItem == item.id ? 0.5 : 0.3,
                        blue: 0))
                }
            }.listStyle(CarouselListStyle())
            }
        }
    }
}

struct PizzaOrderView_Previews: PreviewProvider {
    static var previews: some View {
        PizzaOrderView()
    }
}
