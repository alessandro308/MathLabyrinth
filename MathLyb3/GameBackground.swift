//
//  GameBackground.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 09/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class GameBackground: NSView {
    
    override var acceptsFirstResponder: Bool {get {return true} }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        NSColor.orangeColor().setFill()
        NSBezierPath(rect: NSRect(origin: CGPoint.zero, size: self.frame.size)).fill()
        // Drawing code here.
    }
    
    override func keyDown(theEvent: NSEvent) {
        if(theEvent.keyCode == 53){
            NSApplication.sharedApplication().terminate(self)
        }
    }
    
}
