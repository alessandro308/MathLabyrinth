//
//  GameView.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 25/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class GameView: NSView {
    
    override var acceptsFirstResponder: Bool { return true}
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        self.setFrameSize(NSSize(width: 500, height: 500))
        
        NSBezierPath(rect: NSRect(x: 0, y: 0, width: 500, height: 500)).fill()
        // Drawing code here.
        selectedLevel?.draw()
    }
    
    override func keyDown(theEvent: NSEvent) {
        if(theEvent.keyCode == 53){
            Swift.print(selectedLevel)
            NSApplication.sharedApplication().terminate(self)
        }
    }
    
    
}
