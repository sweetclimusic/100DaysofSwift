//
//  RelaxView.swift
//  FocalBreathing WatchKit Extension
//
//  Created by Ashlee Muscroft on 26/01/2021.
//

import SwiftUI

struct RelaxView: View {
    private var start = NSLocalizedString("start", comment: "the button users click to start the breathing exercise.")
    private var title = NSLocalizedString("relax_title", comment: "title of the selected workout")
    private var description =
        NSLocalizedString("relax_description", comment: "detail description of the current breathing exercise.")
    @State private var isSessionPresented: Bool = false
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(title).font(.title2)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink( destination:RelaxSettingsView() ){
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(maxWidth: 36,maxHeight: 36, alignment: .center)
                        .scaledToFit()
                        .foregroundColor(.tolGreen)
                }
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.componentGrey)
                .clipShape(Circle())
                }.frame( alignment: .topLeading)
            ScrollView{
                Text(description).font(.caption)
            }
            RoundRectangleButton(title: start,action: {
                self.isSessionPresented = true //show
            }).sheet(
                isPresented: $isSessionPresented,
                content: {
                    SessionView(isSessionPresented: $isSessionPresented, item: item)
                })
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct RelaxView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxView()
    }
}
