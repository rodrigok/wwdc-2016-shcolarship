//
//  TodayViewController.swift
//  Notification Center
//
//  Created by Rodrigo Nascimento on 25/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit
import Foundation
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!


    var wwdcDate = NSDate(timeIntervalSince1970: NSTimeInterval(1465837200))
    
    func countDown(timer: NSTimer) {
        let date = NSDate()

        if (date.compare(wwdcDate) == NSComparisonResult.OrderedDescending) {
            timer.invalidate()
            return
        }

        let components: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]

        let dateComponents = NSCalendar.currentCalendar().components(components, fromDate: date, toDate: wwdcDate, options: [])
        
        daysLabel.text = NSString(format: "%02d Days", dateComponents.day) as String
        hoursLabel.text = NSString(format: "%02d Hours", dateComponents.hour) as String
        minutesLabel.text = NSString(format: "%02d Minutes", dateComponents.minute) as String
        secondsLabel.text = NSString(format: "%02d Seconds", dateComponents.second) as String
        daysLabel.alpha = 1
        hoursLabel.alpha = 1
        minutesLabel.alpha = 1
        secondsLabel.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mutableAttributedString = NSMutableAttributedString(string: titleLabel.text!)
        if mutableAttributedString.mutableString.containsString("print(") {
            mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#00aba7"), range: NSRange(location:0, length:5))
            mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#FFFFFF"), range: NSRange(location:5, length:1))
            mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#FFFFFF"), range: NSRange(location:mutableAttributedString.length-1, length:1))
        }
        titleLabel.attributedText = mutableAttributedString

        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TodayViewController.countDown(_:)), userInfo: nil, repeats: true)
        countDown(timer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
