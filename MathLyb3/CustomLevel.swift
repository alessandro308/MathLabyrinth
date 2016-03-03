//
//  CustomLevel.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 28/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class CustomLevel: NSView {
    
    var mouseDown : Bool = false
    var mouseDownPt : NSPoint = NSPoint.zero
    var mouseUpPt : NSPoint = NSPoint.zero
    var mouseOver : Bool = false
    var mousePosition : NSPoint = NSPoint.zero
    let gridSize = 40
    let drawLevelOrigin : NSPoint = NSPoint.zero
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let frame = NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        NSColor(patternImage: NSImage(named: "gridPattern")!).setFill()
        NSBezierPath(rect: frame).fill()
        NSColor(hex: 0x00000, alpha: 0.6).setFill()
        NSBezierPath(rect: frame).fill()
        
        if mouseOver && !mouseDown {
            drawTool()
        }
    }
    
    func drawTool(){
        let square = NSSize(width: self.gridSize, height: self.gridSize)
        let frame = NSRect(origin: NSPoint(x: mousePosition.x-square.width/2,y: mousePosition.y-square.width/2), size: square)
        if selectedTool == tools.border {
            NSColor.whiteColor().setStroke()
            NSBezierPath(rect: frame).stroke()
        }
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        window!.movableByWindowBackground = false
        mouseOver = true
    }
    
    override func mouseExited(theEvent: NSEvent) {
        window!.movableByWindowBackground = true
        mouseOver = false
    }
    
    override func mouseDown(theEvent: NSEvent){
        Swift.print("MouseDown on CustomLevel")
        mouseDown = true
        mouseDownPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("MouseDragged on CustomLevel")
        mouseUpPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        Swift.print("MouseMove on CustomLevel")
        self.needsDisplay = true
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        Swift.print("MouseUp on CustomLevel")
        mouseDown = false
        mouseUpPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    }
}
