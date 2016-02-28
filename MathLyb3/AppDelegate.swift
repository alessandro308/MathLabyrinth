//
//  AppDelegate.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 16/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: BorderlessWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        //let main = PlayGame()
        let main = MainViewController()
        window.contentViewController = main
        window.acceptsMouseMovedEvents = true
        window.styleMask = NSBorderlessWindowMask | NSResizableWindowMask
        window.movableByWindowBackground = true
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    
}

