//
//  HomeViewController.swift
//  Apptendance
//
//  Created by jeffery leo on 4/26/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ESTBeaconManagerDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let beaconManager = ESTBeaconManager()
    let beacon = CLBeacon()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"),identifier: "Apptendance")
    var message:String = ""
    var playSound = false
    
    let colors = [
        16555: UIColor.purpleColor(),
        17792: UIColor.cyanColor(),
        59287: UIColor.greenColor()
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager.delegate = self
        locationManager.delegate = self
        if(locationManager.respondsToSelector("requestAlwaysAuthorization"))
        {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startUpdatingLocation()

        var subjectCodeArray:NSMutableArray = []
        var query = PFQuery(className: "Timetable")
        query.whereKey("Intake", equalTo: "UC2F1410ACS")
        query.whereKey("Day", equalTo: "FRI 22-05-2015")
        query.whereKey("Time", hasPrefix: "11:10")
        query.findObjectsInBackgroundWithBlock
        {
            (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                for object in objects! as [AnyObject]
                {
                    subjectCodeArray.addObject((object["SubjectCode"] as? String)!)
                    println(object["SubjectCode"] as? String)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
//    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
//    {
//        let knownBeacons = beacons.filter{$0.proximity != CLProximity.Unknown}
//        let closestBeacon = knownBeacons[0] as! CLBeacon
////        if(knownBeacons.count > 0)
////        {
////            self.view.backgroundColor =  self.colors[closestBeacon.minor.integerValue]
////            message = "Detected Beacon"
////            playSound = true
////        }
//        if(knownBeacons.count > 0)
//        {
//            if(closestBeacon.minor.integerValue == 17792)
//            {
//                message = "Cyan color Spotted"
//                playSound = true
//            }
//        }
//        
//        sendLocationNotificationMessage(message, playSound: playSound)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!)
    {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.startUpdatingLocation()
        //let time = CustomFunction.getCurrentTime() //get the current time
        //println(time)
        //let date = CustomFunction.getDayDate() //get the day and date WED dd-mm-yyyy
        //println(date)
        //let intake = CustomFunction.getCurrentIntake() //get the current intake
        //println(intake)
        //let username = CustomFunction.getUsername() //get the current username
        //println(username)
        
        var subjectCode:NSMutableArray = []
        var query = PFQuery(className: "Timetable")
        query.whereKey("Intake", equalTo: "UC2F1410ACS")
        query.whereKey("Day", equalTo: "FRI 22-05-2015")
        query.whereKey("Time", hasPrefix: "11:10")
        query.findObjectsInBackgroundWithBlock
        {
            (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil
            {
                println(objects!.count)
                for object in objects! as [AnyObject]
                {
                    subjectCode.addObject((object["SubjectCode"] as? String)!)
                    println(object["SubjectCode"] as! String)
                }
            }
        }
//        println(subjectCode.objectAtIndex(0))
//            let intakeCode = PFUser.currentUser()!["IntakeCode"] as? String
//            var Attendance = PFUser()
//            Attendance.username = PFUser.currentUser()?.username
//            Attendance.setObject(intakeCode!, forKey: "IntakeCode")
            sendLocationNotificationMessage("You are in the class", playSound: true)
    }
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.stopUpdatingLocation()
           sendLocationNotificationMessage("You exited the class", playSound: true)
    }
}

extension HomeViewController:CLLocationManagerDelegate
{
    func sendLocationNotificationMessage(message: String!, playSound:Bool)
    {
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = message
        if(playSound)
        {
            notification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}
