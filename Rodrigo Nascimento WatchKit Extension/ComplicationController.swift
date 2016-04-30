//
//  ComplicationController.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 30/04/16.
//  Copyright © 2016 Rodrigo Nascimento. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    var wwdcDate = NSDate(timeIntervalSince1970: NSTimeInterval(1465837200))
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: 60))
    }
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "WWDC 2016")
            modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "-- Days --h --m")
            modularTemplate.body2TextProvider = CLKSimpleTextProvider(text: "June 13-17 - SF, CA")
            template = modularTemplate

        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "--d")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "--:--")
            template = modularTemplate

        case .UtilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "-- Days --h --m")
            template = modularTemplate
        
        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "--d")
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "--:--")
            template = modularTemplate
                
        default:
            template = nil
        }
        handler(template)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(CLKComplicationPrivacyBehavior.ShowOnLockScreen)
    }
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimelineEntry?) -> Void) {
        switch complication.family {
        case .ModularLarge:
            let date = NSDate()
            
            let modularTemplate = CLKComplicationTemplateModularLargeStandardBody()
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "WWDC 2016")
            
            if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
                modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: "00 Days 00h 00m")
            } else {
                let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
                
                let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
                
                modularTemplate.body1TextProvider = CLKSimpleTextProvider(text: NSString(format: "%02d Days %02dh %02dm", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
            }
            modularTemplate.body2TextProvider = CLKSimpleTextProvider(text: "June 13-17 - SF, CA")
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: modularTemplate)
            handler(timelineEntry)
            
        case .ModularSmall:
            let date = NSDate()
            
            let modularTemplate = CLKComplicationTemplateModularSmallStackText()
            if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
                modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "00d")
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "00:00")
            } else {
                let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
                
                let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
                
                modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: NSString(format: "%02dd", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: NSString(format: "%02d:%02d", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
            }
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: modularTemplate)
            handler(timelineEntry)
        
        case .UtilitarianLarge:
            let date = NSDate()
            
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            
            if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
                modularTemplate.textProvider = CLKSimpleTextProvider(text: "00 Days 00h 00m")
            } else {
                let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
                
                let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
                
                modularTemplate.textProvider = CLKSimpleTextProvider(text: NSString(format: "%02d Days %02dh %02dm", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
            }
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: modularTemplate)
            handler(timelineEntry)
        
        case .CircularSmall:
            let date = NSDate()
            
            let modularTemplate = CLKComplicationTemplateCircularSmallStackText()
            if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
                modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "00d")
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "00:00")
            } else {
                let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
                
                let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
                
                modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: NSString(format: "%02dd", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: NSString(format: "%02d:%02d", dateComponents.day, dateComponents.hour, dateComponents.minute) as String)
            }
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: modularTemplate)
            handler(timelineEntry)

        default:
            handler(nil)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([CLKComplicationTimeTravelDirections.None])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate())
    }
}