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
        self.window?.styleMask = ((self.window?.styleMask)! | NSBorderlessWindowMask | NSResizableWindowMask & ~NSFullScreenWindowMask)
        window.movableByWindowBackground = true
        
            let fileManager = NSFileManager.defaultManager()
            let home = NSHomeDirectory()
            let dataPath = home.stringByAppendingString("/MathLabyrinth")
            let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(dataPath)!
            while let element = enumerator.nextObject() as? String {// checks the extension
                if element.hasSuffix("level"){
                    totalLevel++;
                    let x = try? NSString(contentsOfFile: dataPath+"/"+element, encoding: NSUTF8StringEncoding)
                    let a : NSArray = (x?.componentsSeparatedByString("\n"))!
                    levels.addObject(a[0])
                    levelsFile.setValue(element, forKey: a[0] as! String)
                }
            }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    
}

