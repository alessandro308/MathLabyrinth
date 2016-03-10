//
//  LevelView.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 09/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelView: NSView {
    
    override var acceptsFirstResponder : Bool {get { return true } }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.frame.size = NSSize(width:(selectedLevel?.width)!*40, height: (selectedLevel?.height)!*40)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        selectedLevel?.draw()
        
        // Drawing code here.
    }
    
    override func keyDown(theEvent: NSEvent) {
        let char = theEvent.keyCode
        switch char {
        case 123:
            selectedLevel?.moveLeft()
        case 124:
            selectedLevel?.moveRight()
        case 125:
            selectedLevel?.moveDown()
        case 126:
            selectedLevel?.moveUp()
        case 15:
            selectedLevel?.restart()
        default:
            Swift.print(char)
        }
        self.needsDisplay = true
    }
    
    
    
}
