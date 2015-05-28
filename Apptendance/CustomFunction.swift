//
//  CustomFunction.swift
//  Apptendance
//
//  Created by jeffery leo on 5/22/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import Foundation

public class CustomFunction:NSDate
{
    public class func getDate()->String
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateString = dateFormatter.stringFromDate(NSDate())
        return dateString
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMinute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .LongStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
    public class func getCurrentTime() -> String
    {
//        let date = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "HH:mm"
//        formatter.stringFromDate(date)
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        var dateString = dateFormatter.stringFromDate(NSDate())
        return dateString
    }
    
    public class func getUsername() -> String
    {
        let username = PFUser.currentUser()!["username"] as? String
        return username!
    }
    
    public class func getCurrentIntake() -> String
    {
        let intakeCode = PFUser.currentUser()!["IntakeCode"] as? String
        return intakeCode!
    }
    
    public class func getDayDate() -> String
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateString = dateFormatter.stringFromDate(NSDate())
        
        //get the day of the week
        let dayFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dayFormatter.stringFromDate(NSDate())
        let day = dayOfWeekString.substringToIndex(advance(dayOfWeekString.startIndex, 3))
        
        let fullDate = "\(day.uppercaseString) \(dateString)" as String
        return fullDate
    }
    
    public class func isEqual (lhs: NSDate, rhs: NSDate) -> Bool
    {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
    }
    
    public class func isLessThan (lhs: NSDate, rhs: NSDate) -> Bool
    {
    return lhs.compare(rhs) == .OrderedAscending
    }
    
    public class func isGreaterThan (lhs: NSDate, rhs: NSDate) -> Bool
    {
    return lhs.compare(rhs) == .OrderedDescending
    }

}