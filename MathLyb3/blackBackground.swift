//
//  blackBackground.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 25/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa
import AppKit

class blackBackground: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let offset = CGFloat(10)
        
        NSColor(calibratedWhite: 0, alpha: 0.8).setFill()
        let pt = NSBezierPath(rect: NSRect(x: 0+offset, y: 0+offset, width: self.frame.size.width-2*offset, height: self.frame.size.height-2*offset))
        pt.fill()
        self.alphaValue = 1
        NSColor(hex: 0xd6ecfa, alpha: 1).setStroke()
        let pt1 = NSBezierPath(rect: NSRect(x: 0+offset, y: 0+offset, width: self.frame.size.width-2*offset, height: self.frame.size.height-2*offset))
        pt1.lineJoinStyle = NSLineJoinStyle.RoundLineJoinStyle
        pt1.lineWidth = offset/2
        
        pt1.stroke()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        
    }
}
