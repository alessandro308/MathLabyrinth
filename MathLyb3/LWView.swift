//
//  LWView.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 28/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LWView: NSObject {
    var frame: NSRect;
    var needsDisplay = true
    var origin = NSPoint() //Valori in percentuale rispetto al frame padre
    var size = NSSize() //Valori in percentuale
    var parent: AnyObject? = nil
    
    init(frame: NSRect){
        self.frame = frame
        self.origin = frame.origin
        self.size = frame.size
        self.parent = nil
    }
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, parent: AnyObject){
        //Init object with percent value reletive his NSView container
        self.origin = NSMakePoint(x, y)
        self.size = NSSize(width: width, height: height)
        self.parent = parent
        self.frame = NSRect(x:parent.frame.origin.x*x/100, y: parent.frame.origin.y*y/100, width: parent.frame.size.width*width/100, height: parent.frame.size.height*height/100)
        
    }
    
    func updateFrame(){
        if parent != nil{
            let x = self.origin.x
            let y = self.origin.y
            let width = self.size.width
            let height = self.size.height
            self.frame = NSRect(x:parent!.frame.size.width*x/100,
                                y: parent!.frame.size.height*y/100,
                                width: parent!.frame.size.width*width/100,
                                height: parent!.frame.size.height*height/100)
        }
    }
    
    func drawRect(dirtyRect: NSRect){
        let mtx = NSAffineTransform()
        NSColor.whiteColor().setFill()
        mtx.translateXBy(self.frame.origin.x, yBy: self.frame.origin.y)
        mtx.concat()
        //Draw Here
            //Draw Background
            NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).fill()
        
        mtx.invert()
        mtx.concat()
        needsDisplay = false
    }
}
