//
//  AppDelegate.swift
//  Apptendance
//
//  Created by jeffery leo on 3/31/15.
//  Copyright (c) 2015 jeffery leo. All rights reserved.
//

import UIKit
import Alamofire


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var lastProximity: CLProximity?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("Z13dsgbYDYAuxhWGzkM9DYAy8S3jwf3sSFDOpiGs", clientKey: "UdIwAAgpJX28ZfmmVxsScMKvoxyBhW56pRptplSp")
        ESTCloudManager.setupAppID("apptendance", andAppToken: "9ba851760fe314755e1002ca7332e645")
        //allowthe notification
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil
                )
            )
        }
//        var username = PFObject(className: "Username")
//        username.setObject("jeff", forKey: "name")
//        username.setObject("jeff", forKey: "password")
//        username.save()
        UINavigationBar.appearance().barTintColor = UIColor(red: 58.0/255.0, green: 194.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//        let request = Alamofire.download(.GET, "http://webspace.apiit.edu.my/intake-timetable/download_timetable/timetableCSV.zip", { (temporaryURL, response) in
//            if let directoryURL = NSFileManager.defaultManager()
//                .URLsForDirectory(.DocumentDirectory,
//                    inDomains: .UserDomainMask)[0]
//                as? NSURL {
//                    let pathComponent = response.suggestedFilename
//                    return directoryURL.URLByAppendingPathComponent(pathComponent!)
//            }
//            return temporaryURL
//        })
//        
//        request.response { _, response, data, error in
//            if let data = data as? NSData {
//                println(NSString(data: data, encoding: NSUTF8StringEncoding))
//            } else {
//                println(response)
//                println(error)
//            }
//        }
        
//        if var URL = NSURL(string: "http://webspace.apiit.edu.my/intake-timetable/download_timetable/timetableCSV.zip")
//        {
//            Downloader.load(URL)
//        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
//class Downloader
//{
//    class func load(URL: NSURL)
//    {
//        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
//        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        let request = NSMutableURLRequest(URL:URL)
//        request.HTTPMethod = "GET"
//        let task = session.dataTaskWithRequest(request, completionHandler:{ (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
//            if(error == nil) //success
//            {
//                let statusCode = (response as! NSHTTPURLResponse).statusCode
//                println("Success: \(statusCode)")
//            }
//            else //failed
//            {
//                println("Failure : %@", error.localizedDescription)
//            }
//        })
//        task.resume()
//    }
//}