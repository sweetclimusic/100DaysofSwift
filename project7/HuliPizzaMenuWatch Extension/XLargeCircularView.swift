//
//  XLargeCircularView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Steven Lipton on 7/30/20.
//

import SwiftUI
import ClockKit
struct XLargeCircularView: View {
    var stage:Int
    var stages = Stages()
    var colors:[Color] = [.clear,.red,.yellow,.green,.blue]
    var body: some View {
      let gradient = Gradient(colors: colors)
        VStack {
          if #available(watchOSApplicationExtension 7.0, *) {
            Gauge(
              value: stages.fillFraction(stage: stage),
              in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/,
              label: {
                Text("Huli Pizza")
              },
              currentValueLabel: { Text(stages.emoji(stage)) },
              minimumValueLabel: { Text(stages.emoji(0)) },
              maximumValueLabel: { Text(stages.emoji(stages.count - 1)) }
            ).gaugeStyle(CircularGaugeStyle(tint: gradient))
          } else {
            // Fallback on earlier versions
          }
            Spacer()
//          if #available(watchOSApplicationExtension 7.0, *) {
//            ProgressView(
//              value: stages.fillFraction(stage: stage),
//              label:  { Text(stages.emoji(stage)) }).progressViewStyle(CircularProgressViewStyle(tint: .yellow))
//          } else {
//            // Fallback on earlier versions
//          }
            HStack{
                Spacer()
                Text(stages.text(stage))
                .font(.callout)
                Spacer()
            }
            Spacer()
        }
    }
}


struct XLargeCircularView_Previews: PreviewProvider {
    static var previews: some View {
      XLargeCircularView(stage:2)
      if #available(watchOSApplicationExtension 7.0, *) {
      CLKComplicationTemplateGraphicExtraLargeCircularView(XLargeCircularView(stage: 2)).previewContext()
      }
    }
}
