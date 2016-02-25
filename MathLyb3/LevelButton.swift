//
//  LevelButton.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 16/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelButton: NSButton {
    override var acceptsFirstResponder: Bool {get {return false} }

    var name:NSString = "";
    var number: Int = 0
    var bgColor = NSColor.grayColor()
    var textColor = NSColor.whiteColor()
    
    required init(frame frameRect: NSRect, name: NSString, number: Int) {
        super.init(frame: frameRect)
        self.number = number
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        
        //Draw Number
        let myRect = NSRect(x: 0, y: 0, width: self.frame.width-1, height: self.frame.height-1)
        let font = NSFont(name: "Helvetica", size: 40.0)
        NSColor(hex: 0x6AAFE6, alpha: 0.95).setFill() //Azzurrino
        NSColor.blackColor().setStroke()
        let path = NSBezierPath(rect: myRect)
        path.fill()
        path.stroke()
        
        let attrs : [String: AnyObject] = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: NSColor.blackColor(),
           
        ]
        let numberRect = NSRect(x: myRect.width / 18, y: 0, width: myRect.width*3/9, height: myRect.height)
        NSString(string: self.number < 10 ? "0"+String(self.number) : String(self.number)).drawInRect(numberRect, withAttributes: attrs)
        

    }
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        selectedLevel = self.number
        
    }
}
