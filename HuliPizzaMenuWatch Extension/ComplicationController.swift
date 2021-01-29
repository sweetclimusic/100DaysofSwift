//
//  ComplicationController.swift
//  HuliPizzaMenuWatch Extension
//
//  Created by Ashlee Muscroft on 04/01/2021.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
  let stages: Stages = Stages()
  let customComplication = "customComplication"
    // MARK: - Complication Configuration

  @available(watchOSApplicationExtension 7.0, *)
  func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "HuliPizzaMenu", supportedFamilies: CLKComplicationFamily.allCases),
            // Multiple complication support can be added here with more descriptors
            //custom descriptor for guage and ring templates on the gfxExtraLarge templates
          CLKComplicationDescriptor(identifier: customComplication, displayName: "Huli Pizza Guage", supportedFamilies: [.graphicExtraLarge,.graphicRectangular])
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
  @available(watchOSApplicationExtension 7.0, *)
  func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        //define the length of the timeline using static interval
        handler(now.addingTimeInterval(stages.totalTime))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
      let timelineEntry = createTimeLineEntry(for: complication, date: Date(), stage: 0) // static 0 is a pizza emoticon
        handler(timelineEntry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date

        handler(createOrderTimeline(for: complication))
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let template = createComplicationTemplate(for: complication, stage: 0)
        handler(template)
    }
}
