//
//  CreateLevelController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class MySheetView: NSView {
    override var acceptsFirstResponder: Bool {get {return true} }
    
    var timer: NSTimer? = nil
    var finalFrame:NSRect = NSRect.zero;
    var mouseEventMonitor : AnyObject! = nil
    var clickOutOfBound: Bool = false
    var delta = CGFloat(10)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.finalFrame = frameRect
        
        self.frame = NSRect(x: self.finalFrame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: 0)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "openFrameAnimation", userInfo: nil, repeats: true)
        
        self.mouseEventMonitor = NSEvent.addLocalMonitorForEventsMatchingMask(NSEventMask.LeftMouseDownMask, handler: { (theEvent : NSEvent) -> NSEvent? in
            if !self.frame.contains(theEvent.locationInWindow) && theEvent.clickCount != 2 {
                self.clickOutOfBound = true
            }
            return theEvent
        })
        self.mouseEventMonitor = NSEvent.addLocalMonitorForEventsMatchingMask(NSEventMask.LeftMouseDraggedMask,
            handler: {(theEvent: NSEvent) -> NSEvent? in
                self.clickOutOfBound = false
                return theEvent
            }
        )
        self.mouseEventMonitor = NSEvent.addLocalMonitorForEventsMatchingMask(NSEventMask.LeftMouseUpMask, handler: { (theEvent : NSEvent) -> NSEvent? in
            if self.clickOutOfBound{
                if(self.mouseEventMonitor != nil){
                    NSEvent.removeMonitor(self.mouseEventMonitor)
                    self.mouseEventMonitor = nil
                }
                self.dismissView()
            }
            return theEvent
        })

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func closeFrameAnimation(){
        self.frame = NSRect(x: self.frame.origin.x,
            y: self.frame.origin.y + delta,
            width: self.frame.width,
            height: self.frame.height - delta)
        if(self.frame.height <= 12 ){
            timer?.invalidate()
            timer = nil
            self.removeFromSuperview()
        }
        if(selectedLevel != -1){
            self.window?.contentViewController = PlayGame()
        }
    }
    
    func openFrameAnimation(){
        self.frame = NSRect(x: self.frame.origin.x,
            y: self.frame.origin.y-delta,
            width: self.frame.width,
            height: self.frame.height + delta)
        if(self.frame.height >= self.finalFrame.height - 1){
            self.frame = self.finalFrame
            timer?.invalidate()
            timer = nil
        }
        onOpen()
        self.needsDisplay = true
    }
    
    func dismissView(){
        delta = self.frame.height/35
        if (timer != nil) {
            timer?.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "closeFrameAnimation", userInfo: nil, repeats: true)
        //self.superview?.becomeFirstResponder()
    }
    
    func onOpen(){
        
    }
    
}
