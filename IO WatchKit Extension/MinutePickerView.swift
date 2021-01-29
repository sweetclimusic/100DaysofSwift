//
//  MinutePickerView.swift
//  IO WatchKit Extension
//
//  Created by Ashlee Muscroft on 28/01/2021.
//

import SwiftUI

struct MinutePickerView: View {
    @State var selectedItem: Int = 0
    var description: String = "relax_mins_picker"
    var label: String = "Min"
    var range: Range = 1..<11
    var body: some View {
        HStack{
            Picker(description, selection: $selectedItem) {
                ForEach(range){
                    Text("\($0)")
                        .font(.largeTitle)
                }
            }
            .labelsHidden()
            .frame(width: 60, height: 38)
            .scaledToFit()
            .clipped()
            .padding(.trailing)

            Text(label).font(.title2)
        }
    }
}

struct MinutePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MinutePickerView()
    }
}
