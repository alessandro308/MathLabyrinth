//
//  Toolbar.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 02/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

enum tools {
    case exit
    case simple
    case oneShot
    case conditional
    case pan
    case null
    case editCell
    case block
    case startPosition
    case clear
}

var selectedTool : tools = tools.pan


class Toolbar: NSView {
    
    var panFrame : NSRect = NSRect.zero;
    var exitFrame : NSRect = NSRect.zero;
    var sempliceFrame : NSRect = NSRect.zero;
    var conditionalFrame : NSRect = NSRect.zero;
    var borderFrame : NSRect = NSRect.zero;
    var oneShotFrame : NSRect = NSRect.zero;
    var editCellFrame : NSRect = NSRect.zero;
    var blockFrame : NSRect = NSRect.zero;
    var startPositionFrame : NSRect = NSRect.zero;
    var clearFrame : NSRect = NSRect.zero;
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let offset = self.frame.width / 5
        let square = NSSize(width: self.frame.width-offset, height: self.frame.width/2-offset)
        let x = offset/2
        panFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 7*(square.height + offset)), size: square)
        exitFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 2*(square.height + offset)), size: square)
        sempliceFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 3*(square.height + offset)), size: square)
        conditionalFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 5*(square.height + offset)), size: square)
        oneShotFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 4*(square.height + offset)), size: square)
        editCellFrame = NSRect(origin: NSMakePoint(x, self.frame.height - (square.height + offset)), size: square)
        blockFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 6*(square.height + offset)), size: NSSize(width: square.width/2 - 1, height: square.height))
        clearFrame = NSRect(origin: NSMakePoint(x+square.width/2+1, self.frame.height - 6*(square.height + offset)), size: NSSize(width: square.width/2-1, height: square.height))
        startPositionFrame = NSRect(origin: NSMakePoint(x + square.width / 2 + 1, self.frame.height - 2*(square.height + offset)), size: NSSize(width: square.width/2, height: square.height))
        exitFrame = NSRect(origin: NSMakePoint(x - 1, self.frame.height - 2*(square.height + offset)), size: NSSize(width: square.width/2, height: square.height))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        //Background
        NSColor(calibratedWhite: 0.8, alpha: 0.8).setFill()
        NSBezierPath(rect: NSRect(origin: CGPoint.zero, size: self.frame.size)).fill()
        
        //Evidenzia tools selezionato
        NSColor.whiteColor().setFill()
        switch selectedTool{
        case .editCell:
            NSBezierPath(rect:editCellFrame).fill()
        case .clear:
            NSBezierPath(rect: clearFrame).fill()
        case .conditional:
            NSBezierPath(rect: conditionalFrame).fill()
        case .exit:
            NSBezierPath(rect: exitFrame).fill()
        case .oneShot:
            NSBezierPath(rect: oneShotFrame).fill()
        case .pan:
            NSBezierPath(rect: panFrame).fill()
        case .block:
            NSBezierPath(rect: blockFrame).fill()
        case .simple:
            NSBezierPath(rect: sempliceFrame).fill()
        case .startPosition:
            NSBezierPath(rect: startPositionFrame).fill()
        default:
            break
        }
        
        
        //Inizia a disegnare i tools vari
        
        //EditCell
        NSColor.grayColor().setStroke()

        NSBezierPath(rect: editCellFrame).stroke()
        var str = NSString(string:"Edit")
        var attrs : [String : AnyObject] = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 15)!
        ]
        str.drawInRect(NSRect(x: editCellFrame.origin.x + 6, y: editCellFrame.origin.y, width: editCellFrame.width, height: editCellFrame.height), withAttributes: attrs)
        
        //Exit
        NSColor.yellowColor().setStroke()
        
        NSBezierPath(rect: exitFrame).stroke()
        str = NSString(string:"Exit")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 9)!
        ]
        str.drawInRect(NSRect(x: exitFrame.origin.x+3, y: exitFrame.origin.y - 7, width: exitFrame.width-2, height: exitFrame.height+3), withAttributes: attrs)
        
        //Operazione Semplice
        NSColor.greenColor().setStroke()
        NSBezierPath(rect: sempliceFrame).stroke()
        str = NSString(string:"*n")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 15)!
        ]
        str.drawInRect(NSRect(x: sempliceFrame.origin.x + 12, y: sempliceFrame.origin.y, width: sempliceFrame.width, height: sempliceFrame.height), withAttributes: attrs)
        
        //Operazione oneshot
        NSColor.blueColor().setStroke()
        NSBezierPath(rect: oneShotFrame).stroke()
        str = NSString(string:"/n")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 15)!
        ]
        str.drawInRect(NSRect(x: oneShotFrame.origin.x + 12, y: oneShotFrame.origin.y, width: oneShotFrame.width, height: oneShotFrame.height), withAttributes: attrs)
        
        //Operazione Condizionale
        NSColor.redColor().setStroke()
        NSBezierPath(rect: conditionalFrame).stroke()
        str = NSString(string:"<n")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 15)!
        ]
        str.drawInRect(NSRect(x: conditionalFrame.origin.x + 12, y: conditionalFrame.origin.y, width: conditionalFrame.width, height: conditionalFrame.height), withAttributes: attrs)
        
        //PAN
        NSColor.redColor().setStroke()
        NSBezierPath(rect: panFrame).stroke()
        str = NSString(string:"PAN")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 15)!
        ]
        str.drawInRect(NSRect(x: panFrame.origin.x + 10, y: panFrame.origin.y, width: panFrame.width, height: panFrame.height), withAttributes: attrs)
        
        //BLOCK
        NSColor.grayColor().setStroke()
        NSBezierPath(rect: blockFrame).stroke()
        str = NSString(string:"Wall")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 9)!
        ]
        str.drawInRect(NSRect(x: blockFrame.origin.x + 2, y: blockFrame.origin.y, width: blockFrame.width, height: blockFrame.height-3), withAttributes: attrs)
        
        //CLEAR
        NSColor(hex:0x4C3100).setStroke()
        NSBezierPath(rect: clearFrame).stroke()
        str = NSString(string:"Del")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 9)!
        ]
        str.drawInRect(NSRect(x: clearFrame.origin.x + 4, y: clearFrame.origin.y, width: clearFrame.width, height: clearFrame.height-3), withAttributes: attrs)
        
        //START
        NSColor.orangeColor().setStroke()
        
        NSBezierPath(rect: self.startPositionFrame).stroke()
        str = NSString(string:"You")
        attrs = [
            NSFontAttributeName: NSFont(name: "CODE Bold", size: 9)!
        ]
        str.drawInRect(NSRect(x: startPositionFrame.origin.x+3, y: startPositionFrame.origin.y - 7, width: startPositionFrame.width-4, height: startPositionFrame.height+3), withAttributes: attrs)
        
    }
    
    override func setFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        let offset = self.frame.width / 5
        let square = NSSize(width: self.frame.width-offset, height: self.frame.width/2-offset)
        let x = offset/2
        
        panFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 7*(square.height + offset)), size: square)
        exitFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 2*(square.height + offset)), size: square)
        sempliceFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 3*(square.height + offset)), size: square)
        conditionalFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 5*(square.height + offset)), size: square)
        oneShotFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 4*(square.height + offset)), size: square)
        editCellFrame = NSRect(origin: NSMakePoint(x, self.frame.height - (square.height + offset)), size: square)
        blockFrame = NSRect(origin: NSMakePoint(x, self.frame.height - 6*(square.height + offset)), size: NSSize(width: square.width/2 - 1, height: square.height))
        clearFrame = NSRect(origin: NSMakePoint(x+square.width/2+1, self.frame.height - 6*(square.height + offset)), size: NSSize(width: square.width/2-1, height: square.height))
        startPositionFrame = NSRect(origin: NSMakePoint(x + square.width / 2 + 1, self.frame.height - 2*(square.height + offset)), size: NSSize(width: square.width/2, height: square.height))
        exitFrame = NSRect(origin: NSMakePoint(x - 1, self.frame.height - 2*(square.height + offset)), size: NSSize(width: square.width/2, height: square.height))
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let pt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        if panFrame.contains(pt){
            selectedTool = tools.pan
        }
        else if editCellFrame.contains(pt){
            selectedTool = tools.editCell
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
        else if blockFrame.contains(pt){
            selectedTool = tools.block
        }
        else if startPositionFrame.contains(pt){
            selectedTool = tools.startPosition
        }
        else if clearFrame.contains(pt){
            selectedTool = tools.clear
        }
        else{
            selectedTool = tools.null
        }
        self.needsDisplay = true
    }
    
}
