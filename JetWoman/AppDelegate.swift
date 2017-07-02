//
//  AppDelegate.swift
//  JetWoman
//
//  Created by Mitch Guzman on 7/2/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction func resetScoreClicked(_ sender: Any) {
        print("Reset High Score")
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}
