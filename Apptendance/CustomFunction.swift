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
//        formatter.timeStyle = .ShortStyle
//        var stringValue = formatter.stringFromDate(date)
//        return stringValue
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
}