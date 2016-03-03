//
//  Toolbar.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 02/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

enum tools {
    case border
    case exit
    case simple
    case oneShot
    case conditional
    case pan
}

var selectedTool : tools = tools.pan


class Toolbar: NSView {
    
    var panFrame : NSRect = NSRect.zero;
    var exitFrame : NSRect = NSRect.zero;
    var sempliceFrame : NSRect = NSRect.zero;
    var conditionalFrame : NSRect = NSRect.zero;
    var borderFrame : NSRect = NSRect.zero;
    var oneShotFrame : NSRect = NSRect.zero;
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let offset = self.frame.width / 5
        let square = NSSize(width: self.frame.width-offset, height: self.frame.width-offset)
        let x = offset/2
        
        panFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 7*(square.height + offset)), size: square)
        exitFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 2*(square.height + offset)), size: square)
        sempliceFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 3*(square.height + offset)), size: square)
        conditionalFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 5*(square.height + offset)), size: square)
        borderFrame = NSRect(origin: NSMakePoint(x, self.frame.height - square.height - offset), size: square)
        oneShotFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 4*(square.height + offset)), size: square)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        //Background
        NSColor.darkGrayColor().setFill()
        NSBezierPath(rect: NSRect(origin: CGPoint.zero, size: self.frame.size)).fill()
        
        //Rettangolo Iniziale
        NSColor.whiteColor().setStroke()
        NSBezierPath(rect: borderFrame).stroke()
        
        //Exit
        NSColor.yellowColor().setStroke()
        
        NSBezierPath(rect: exitFrame).stroke()
        var str = NSString(string:"Exit")
        var attrs : [String : AnyObject] = [
            NSFontAttributeName: NSFont(name: "Courier", size: 11)!
        ]
        str.drawInRect(NSRect(x: exitFrame.origin.x + 4, y: exitFrame.origin.y - 7, width: exitFrame.width, height: exitFrame.height), withAttributes: attrs)
        
        //Operazione Semplice
        NSColor.greenColor().setStroke()
        NSBezierPath(rect: sempliceFrame).stroke()
        str = NSString(string:"*n")
        attrs = [
            NSFontAttributeName: NSFont(name: "Courier", size: 15)!
        ]
        str.drawInRect(NSRect(x: sempliceFrame.origin.x + 6, y: sempliceFrame.origin.y - 7, width: sempliceFrame.width, height: sempliceFrame.height), withAttributes: attrs)
        
        //Operazione oneshot
        NSColor.blueColor().setStroke()
        NSBezierPath(rect: oneShotFrame).stroke()
        str = NSString(string:"/n")
        attrs = [
            NSFontAttributeName: NSFont(name: "Courier", size: 15)!
        ]
        str.drawInRect(NSRect(x: oneShotFrame.origin.x + 6, y: oneShotFrame.origin.y - 7, width: oneShotFrame.width, height: oneShotFrame.height), withAttributes: attrs)
        
        //Operazione Condizionale
        NSColor.redColor().setStroke()
        NSBezierPath(rect: conditionalFrame).stroke()
        str = NSString(string:"<n")
        attrs = [
            NSFontAttributeName: NSFont(name: "Courier", size: 15)!
        ]
        str.drawInRect(NSRect(x: conditionalFrame.origin.x + 6, y: conditionalFrame.origin.y - 7, width: conditionalFrame.width, height: conditionalFrame.height), withAttributes: attrs)
        
        //PAN
        NSColor.redColor().setStroke()
        NSBezierPath(rect: panFrame).stroke()
        str = NSString(string:"PAN")
        attrs = [
            NSFontAttributeName: NSFont(name: "Courier", size: 15)!
        ]
        str.drawInRect(NSRect(x: panFrame.origin.x + 6, y: panFrame.origin.y - 7, width: panFrame.width, height: panFrame.height), withAttributes: attrs)
    }
    
    override func setFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        let offset = self.frame.width / 5
        let square = NSSize(width: self.frame.width-offset, height: self.frame.width-offset)
        let x = offset/2
        
        panFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 7*(square.height + offset)), size: square)
        exitFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 2*(square.height + offset)), size: square)
        sempliceFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 3*(square.height + offset)), size: square)
        conditionalFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 5*(square.height + offset)), size: square)
        borderFrame = NSRect(origin: NSMakePoint(x, self.frame.height - square.height - offset), size: square)
        oneShotFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 4*(square.height + offset)), size: square)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let pt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        if borderFrame.contains(pt) {
            selectedTool = tools.border
        }
        else if panFrame.contains(pt){
            selectedTool = tools.pan
        }
        else if exitFrame.contains(pt){
            selectedTool = tools.exit
        }
        else if sempliceFrame.contains(pt){
            selectedTool = tools.simple
        }
        else if conditionalFrame.contains(pt){
            selectedTool = tools.conditional
        }
        else if oneShotFrame.contains(pt){
            selectedTool = tools.oneShot
        }
    }
    
}
