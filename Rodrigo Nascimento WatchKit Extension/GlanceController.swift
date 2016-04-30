//
//  GlanceController.swift
//  Rodrigo Nascimento WatchKit Extension
//
//  Created by Rodrigo Nascimento on 24/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var daysLabel: WKInterfaceLabel!
    @IBOutlet var hoursLabel: WKInterfaceLabel!
    @IBOutlet var minutesLabel: WKInterfaceLabel!
    @IBOutlet var secondsLabel: WKInterfaceLabel!

    var wwdcDate = NSDate(timeIntervalSince1970: NSTimeInterval(1465837200))
    
    func countDown(timer: NSTimer) {
        let date = NSDate()
        
        if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
            timer.invalidate()
            return
        }
        
        let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
        
        let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
        
        daysLabel.setText(NSString(format: "%02d Days", dateComponents.day) as String)
        hoursLabel.setText(NSString(format: "%02d Hours", dateComponents.hour) as String)
        minutesLabel.setText(NSString(format: "%02d Minutes", dateComponents.minute) as String)
        secondsLabel.setText(NSString(format: "%02d Seconds", dateComponents.second) as String)
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(InterfaceController.countDown(_:)), userInfo: nil, repeats: true)
        countDown(timer)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
