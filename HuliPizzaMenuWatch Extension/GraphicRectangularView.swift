//
//  GraphicRectangularView.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 09/01/2021.
//
import ClockKit
import SwiftUI

struct GraphicRectangularView: View {
  let stage:Int
  let stages = Stages()
    var body: some View {
      let colors:[Color] = [.red,.yellow]
      let gradient = Gradient(colors: colors)
      HStack{
        Text(stages.emoji(stage)).font(.largeTitle)
          .scaledToFill()
        VStack{
          Text("Huli Pizza Co.").font(.body).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          if #available(watchOSApplicationExtension 7.0, *) {
            Gauge(
              value: stages.fillFraction(stage: stage),
              in: 0...1,
              label: {
                Text("Huli Pizza")
              }
            ).gaugeStyle(LinearGaugeStyle(tint: gradient)).frame(width:120)
          }
          Text(stages.text(stage)).font(.callout)
        }

      }
    }
}

struct GraphicRectangularView_Previews: PreviewProvider {
    static var previews: some View {
      GraphicRectangularView(stage: 0)
      if #available(watchOSApplicationExtension 7.0, *) {
        CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangularView(stage: 0)).previewContext()
      }
    }
}
