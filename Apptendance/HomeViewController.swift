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
        let time = CustomFunction.getCurrentTime()
        println(time)
        let date = CustomFunction.getDate()
        println(date)
        let intake = CustomFunction.getCurrentIntake()
        println(intake)
        let username = CustomFunction.getUsername()
        println(username)
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
        let time = CustomFunction.getCurrentTime()
        println(time)
        let date = CustomFunction.getDate()
        println(date)
        let intake = CustomFunction.getCurrentIntake()
        println(intake)
        let username = CustomFunction.getUsername()
        println(username)
        var query = PFQuery(className: "Timetable")
            
//            let intakeCode = PFUser.currentUser()!["IntakeCode"] as? String
//            var Attendance = PFUser()
//            Attendance.username = PFUser.currentUser()?.username
//            Attendance.setObject(intakeCode!, forKey: "IntakeCode")
//            sendLocationNotificationMessage("You are in the class", playSound: true)
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
