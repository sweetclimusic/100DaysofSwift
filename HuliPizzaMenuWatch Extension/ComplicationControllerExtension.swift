//
//  ComplicationControllerExtension.swift
//  TestComplications WatchKit Extension
//
//  Created by Steven Lipton on 7/17/20.
//

import ClockKit
import SwiftUI

/// a static date for the beginning of a complication timeline set to the pass to prevent starting autimatically.
var now = Date(timeIntervalSince1970: 0)



extension ComplicationController{
  
  //MARK: - Complication providers

  //basic text provider, example UNUSED!
  func text( _ text:String )->CLKSimpleTextProvider{
    return CLKSimpleTextProvider(text: text)
  }
  func pizzaStage(stage:Int)->CLKSimpleTextProvider{
    return CLKSimpleTextProvider(text: stages.text(stage))
  }
  func pizzaEmoji(stage:Int)->CLKSimpleTextProvider{
    return CLKSimpleTextProvider(text: stages.emoji(stage))
  }

  func estimatedTime(from date:Date) -> CLKRelativeDateTextProvider{
    if #available(watchOSApplicationExtension 7.0, *) {
      return CLKRelativeDateTextProvider(date: date, relativeTo: date.addingTimeInterval(stages.totalTime), style: .timer, units: [.minute,.second])
    } else {
      // Fallback on earlier versions I am currently support 6.8
      if stages.totalTime > 0 {
        let relativeTimeSinceOrder = date.addingTimeInterval(stages.totalTime * 60)
        let delta = date.timeIntervalSince(relativeTimeSinceOrder)
        return CLKRelativeDateTextProvider(date: date.addingTimeInterval(delta) , style: .timer, units: [.minute,.second])
      }
      return CLKRelativeDateTextProvider(date: date , style: .timer, units: [.minute,.second])
    }
  }
  // images -- Note due to a lot of images necessary for this, I am only using SF Symbols.

  func ringGauge(stage:Int) -> CLKSimpleGaugeProvider {
    return CLKSimpleGaugeProvider(style: .ring, gaugeColor: .yellow,
                                  fillFraction: stages.fillFraction(stage: stage))
  }

  func image(stage:Int) -> CLKImageProvider{
    return CLKImageProvider(onePieceImage: stages.symbol(stage) )
  }

  func colorImage(stage:Int) -> CLKFullColorImageProvider {
    return CLKFullColorImageProvider(fullColorImage: stages.symbol(stage), tintedImageProvider: image(stage: stage))
  }

  func openGauge(stage:Int) -> CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText {
    let openGauge = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
    openGauge.bottomTextProvider = estimatedTime(from: now)
    openGauge.centerTextProvider = pizzaEmoji(stage: stage)
    openGauge.gaugeProvider = ringGauge(stage: stage)
    return openGauge
  }


  //All Families are represented here, but we are only using some for this demonstration.
  ///Creates the proper template for the complication, and populates it with data.
  //MARK: - Complication Templates
  func createComplicationTemplate(for complication:CLKComplication, stage:Int)-> CLKComplicationTemplate!{
    var template:CLKComplicationTemplate? = nil

    switch complication.family{
      //MARK: Circular Family
      case .circularSmall:
        template = nil
      //MARK: Modular Family
      case .modularLarge:
        template = nil
      case .modularSmall:
        template = nil
      //MARK:Utilitarian family
      case .utilitarianLarge:
        let large = CLKComplicationTemplateUtilitarianLargeFlat()
        large.textProvider = pizzaStage(stage: stage)
        large.imageProvider = image(stage: stage)
        template = large
      case .utilitarianSmall:
        let small = CLKComplicationTemplateUtilitarianSmallRingImage()
        small.imageProvider = image(stage: stage)
        small.fillFraction = stages.fillFraction(stage: stage)
        small.ringStyle = .closed
        template = small
      case .utilitarianSmallFlat:
        if #available(watchOSApplicationExtension 7.0, *) {
          template = CLKComplicationTemplateUtilitarianSmallFlat(
            textProvider: pizzaStage(stage: stage),
            imageProvider: image(stage: stage))
        } else {
          let smallFlat = CLKComplicationTemplateUtilitarianSmallFlat()
          smallFlat.textProvider = pizzaStage(stage: stage)
          smallFlat.imageProvider = image(stage: stage)
          template = smallFlat
        }
      //MARK:Extra large
      // this will default for any watch 3 if Graphcextralarge is used.
      case .extraLarge:
        let ex = CLKComplicationTemplateExtraLargeRingText()
        ex.fillFraction = stages.fillFraction(stage: stage)
        ex.ringStyle = .closed
        ex.textProvider = pizzaEmoji(stage: stage)
        template = ex
      //MARK:Graphic Family
      case .graphicExtraLarge:
        if #available(watchOSApplicationExtension 7.0, *) {
          if complication.identifier == customComplication {
           template = CLKComplicationTemplateGraphicExtraLargeCircularView(XLargeCircularView(stage:stage))
          } else {
          template = CLKComplicationTemplateGraphicExtraLargeCircularClosedGaugeView(
            gaugeProvider: ringGauge(stage: stage),
            label: Text(stages.emoji(stage)))
          }
        }
      case .graphicRectangular:
        if #available(watchOSApplicationExtension 7.0, *) {
          if complication.identifier == customComplication {
            template = CLKComplicationTemplateGraphicRectangularFullView(GraphicRectangularView(stage:stage))
          }else {
            template = nil
          }
        }
      case .graphicBezel:
        let bezel = CLKComplicationTemplateGraphicBezelCircularText()
        bezel.textProvider = pizzaStage(stage: stage)
        let circular = openGauge(stage: stage)
        bezel.circularTemplate = circular
        template = bezel
      case .graphicCircular:
          template = openGauge(stage: stage)
      case .graphicCorner:
        let gfxCorner = CLKComplicationTemplateGraphicCornerGaugeText()
        gfxCorner.gaugeProvider = ringGauge(stage: stage)
        gfxCorner.leadingTextProvider = estimatedTime(from: now)
        gfxCorner.trailingTextProvider = nil
        gfxCorner.outerTextProvider = pizzaEmoji(stage: stage)
        template = gfxCorner
      default:
        template = nil
        print("complication with raw value \(complication.family) not found")
    }
    return template
  }
  //MARK: - Complication Timelines
  //schedule events to change data on the complication, these can be single timeline entries aka(now, 12pm) or schedule entries for some future data.
  func createTimeLineEntry(for complication:CLKComplication, date:Date,stage:Int)-> CLKComplicationTimelineEntry?{
    if let template = createComplicationTemplate(for: complication, stage: stage) {
      return CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    }
    return nil
  }

  func createOrderTimeline(for complication: CLKComplication)->[CLKComplicationTimelineEntry]?{
    var timelineEntries:[CLKComplicationTimelineEntry]? = []
    for stage in 1..<stages.count{
      if let timeLineEntry = createTimeLineEntry(
            for: complication,
            date: now.addingTimeInterval(
              stages.times(stage)),stage: stage)
      {
        timelineEntries?.append(timeLineEntry)
      }
    }
    //reset to timelineEntry to stage 0
    let timeLineEntry = createTimeLineEntry(
            for: complication,
            date: now.addingTimeInterval(stages.totalTime),
            stage: 0)!
    timelineEntries?.append(timeLineEntry)
    return timelineEntries

  }

}
