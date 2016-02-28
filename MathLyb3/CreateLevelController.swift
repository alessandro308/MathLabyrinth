//
//  CreateLevelController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class CreateLevelController: MySheetView {
    override func drawRect(dirtyRect: NSRect) {
        NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).fill()
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 0x35{
            self.dismissView()
        }
    }
}
