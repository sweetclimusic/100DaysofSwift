//
//  RelaxSettingsView.swift
//  IO WatchKit Extension
//
//  Created by Ashlee Muscroft on 27/01/2021.
//

import SwiftUI

struct RelaxSettingsView: View {
    private static var relaxSettingsKeyMins: String = "RelaxSettingsMin"
    private static var relaxSettingsKeySecs: String = "RelaxSettingsSeconds"
    @State private var selectedMin: Int = UserDefaults.standard.integer(forKey: relaxSettingsKeyMins)
    @State private var selectedSec: Int = UserDefaults.standard.integer(forKey: relaxSettingsKeySecs)
    private let breathsLabel = NSLocalizedString("relax_settings_breaths", comment: "")
    private let restLabel = NSLocalizedString("relax_settings_rest", comment: "")
    //4-7-8 sec in a minute
    private let cal478 = Int(60/(4+7+8))
    var body: some View {
        VStack(alignment:.leading){
            let breathCount: Int = selectedMin * cal478
            //shadow label for picker
            Text("\(breathCount < 1 ? 1 : breathCount) \(breathsLabel)")
                .font(.footnote)
                .foregroundColor(.gray)
            MinutePickerView(selectedItem: selectedMin, description: "relax_mins_picker", label:NSLocalizedString("relax_mins_label", comment: ""))
                .onChange(of: selectedMin) { newValue in
            UserDefaults.standard.setValue(selectedMin, forKey: RelaxSettingsView.relaxSettingsKeyMins)
                }

            //shadow label for other picker
            Text(restLabel)
                .font(.footnote)
                .foregroundColor(.gray)
            MinutePickerView(
                selectedItem: selectedSec,
                description: "relax_secs_picker",
                label:NSLocalizedString("relax_secs_label", comment: ""),
                range: 10..<30)
                .onChange(of: selectedSec) { newValue in
                    UserDefaults.standard.setValue(selectedSec, forKey: RelaxSettingsView.relaxSettingsKeySecs)
                }
            //because of onChange, not needed...
            HStack{
                RoundRectangleButton(title:NSLocalizedString("btn_cancel", comment: ""), action: {})
                RoundRectangleButton(title:NSLocalizedString("btn_ok", comment: ""), action: {},fillColor: Color.tolGreen)
            }
        }.navigationBarTitle("relax_settings_title")
    }
}

struct RelaxSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxSettingsView()
    }
}
