//
//  CreateLevelController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class CreateLevelController: MySheetView {
    
    var lwviews: [LWView] = []
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        lwviews.append(LWView(x: 75, y: 50, width: 25, height: 50, parent: self))
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onResize:", name: NSWindowDidResizeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).fill()
        for subview in lwviews {
            subview.drawRect(dirtyRect)
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 0x35{
            self.dismissView()
        }
    }

    func onResize(theEvent : NSEvent){
        for subview in lwviews {
            subview.updateFrame()
        }
        self.needsDisplay = true
    }
    
    override func onOpen() {
        for subview in lwviews {
            subview.updateFrame()
        }
    }
    
    
}
