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
    let gridSize : CGFloat = 40
    let drawLevelOrigin : NSPoint = NSPoint.zero
    var mtx = NSAffineTransform()
    var ultimoPuntoTraslato = NSPoint.zero
    var levelPositionOriginPoint : NSPoint? = nil
    let level = Level(width: 40, height: 30)
    let mtxTools = NSAffineTransform()
    var saveLevelInput : SaveTextInput? = nil ;
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        saveLevelInput = SaveTextInput(frame: NSRect(origin: NSPoint.zero, size: CGSize(width: 100, height: 20)))
        saveLevelInput!.target = saveLevelInput
        saveLevelInput!.placeholderString = "Save Level"
        saveLevelInput!.level = self.level
        self.addSubview(saveLevelInput!)
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let frame = NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        NSColor(hex: 0x00000, alpha: 0.8).setFill()
        NSBezierPath(rect: frame).fill()
        
        //DrawLevel
        mtx.concat()
            drawLevel()
        mtx.invert()
        mtx.concat()
        mtx.invert()
        
        if mouseOver && !mouseDown {
            drawTool()
        }
        else if mouseDown && mouseDown{
            drawDragTool()
        }
    }
    
    func drawLevel(){
        level.draw(true)
    }
    
    func drawDragTool(){
        let center = self.mousePosition
        //Disegna i tool che seguono il mouse
        let square = NSSize(width: self.gridSize-10, height: self.gridSize-10)
        let frameTool = NSRect(origin: NSPoint(x: mousePosition.x-self.gridSize/2,
            y: mousePosition.y-self.gridSize/2), size: square)
        
        switch selectedTool{
            
        case tools.pan:
            let mtx = NSAffineTransform()
            mtx.translateXBy(center.x, yBy: center.y)
            mtx.concat()
            NSColor.whiteColor().setStroke()
            
            let bz = NSBezierPath()
            bz.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
            bz.moveToPoint(NSMakePoint(-10, 0))
            bz.lineToPoint(NSMakePoint(10, 0))
            bz.stroke()
            let bz1 = NSBezierPath()
            bz1.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
            bz1.moveToPoint(NSMakePoint(0, -10))
            bz1.lineToPoint(NSMakePoint(0, 10))
            bz1.stroke()
            
            mtx.invert()
            mtx.concat()
            
        case tools.block:
            //Operazione oneshot
            NSColor.darkGrayColor().setFill()
            NSBezierPath(rect: frameTool).fill()
            
        case tools.clear:
            //Operazione oneshot
            NSColor.darkGrayColor().setFill()
            NSBezierPath(rect: frameTool).fill()
        
        case tools.exit:
            let exitFrame = frameTool
            NSColor.yellowColor().setStroke()
            
            NSBezierPath(rect: exitFrame).stroke()
            let str = NSString(string:"Exit")
            let attrs : [String : AnyObject] = [
                NSFontAttributeName: NSFont(name: "Courier", size: 10)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: exitFrame.origin.x + 4, y: exitFrame.origin.y - 7, width: exitFrame.width, height: exitFrame.height), withAttributes: attrs)
            
        case tools.startPosition:
            let exitFrame = frameTool
            NSColor.orangeColor().setStroke()
            
            NSBezierPath(rect: exitFrame).stroke()
            let str = NSString(string:"YOU")
            let attrs : [String : AnyObject] = [
                NSFontAttributeName: NSFont(name: "Courier", size: 12)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: exitFrame.origin.x + 3, y: exitFrame.origin.y - 7, width: exitFrame.width, height: exitFrame.height), withAttributes: attrs)
        
        case tools.conditional:
            NSColor.redColor().setStroke()
            NSBezierPath(rect: frameTool).stroke()
            let str = NSString(string:"<n")
            let attrs = [
                NSFontAttributeName: NSFont(name: "Courier", size: 15)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: frameTool.origin.x + 6, y: frameTool.origin.y - 7, width: frameTool.width, height: frameTool.height), withAttributes: attrs)
        case tools.simple:
            let sempliceFrame = frameTool
            //Operazione Semplice
            NSColor.greenColor().setStroke()
            NSBezierPath(rect: sempliceFrame).stroke()
            let str = NSString(string:"*n")
            let attrs = [
                NSFontAttributeName: NSFont(name: "Courier", size: 17)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: sempliceFrame.origin.x + 6, y: sempliceFrame.origin.y - 7, width: sempliceFrame.width, height: sempliceFrame.height), withAttributes: attrs)
        case tools.oneShot:
            let oneShotFrame = frameTool
            //Operazione oneshot
            NSColor.blueColor().setStroke()
            NSBezierPath(rect: oneShotFrame).stroke()
            let str = NSString(string:"/n")
            let attrs = [
                NSFontAttributeName: NSFont(name: "Courier", size: 17)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: oneShotFrame.origin.x + 6, y: oneShotFrame.origin.y - 7, width: oneShotFrame.width, height: oneShotFrame.height), withAttributes: attrs)
            
        default:
            break
        }
    }
    
    func drawTool(){
        //Disegna i tool che seguono il mouse
        let square = NSSize(width: self.gridSize-10, height: self.gridSize-10)
        let frameTool = NSRect(origin: NSPoint(x: mousePosition.x-self.gridSize/2,
                                           y: mousePosition.y-self.gridSize/2), size: square)
        
        switch selectedTool{
            case tools.conditional:
                NSColor.redColor().setStroke()
                NSBezierPath(rect: frameTool).stroke()
                let str = NSString(string:"<n")
                let attrs = [
                    NSFontAttributeName: NSFont(name: "Courier", size: 15)!,
                    NSForegroundColorAttributeName: NSColor.whiteColor()
                ]
                str.drawInRect(NSRect(x: frameTool.origin.x + 6, y: frameTool.origin.y - 7, width: frameTool.width, height: frameTool.height), withAttributes: attrs)
            
            case tools.pan:
                let center = self.mousePosition
                let mtx = NSAffineTransform()
                mtx.translateXBy(center.x, yBy: center.y)
                mtx.concat()
                NSColor.whiteColor().setStroke()
       
                    let bz = NSBezierPath()
                    bz.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
                    bz.moveToPoint(NSMakePoint(-10, 0))
                    bz.lineToPoint(NSMakePoint(10, 0))
                    bz.stroke()
                    let bz1 = NSBezierPath()
                    bz1.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
                    bz1.moveToPoint(NSMakePoint(0, -10))
                    bz1.lineToPoint(NSMakePoint(0, 10))
                    bz1.stroke()
                
                mtx.invert()
                mtx.concat()
            
            case tools.exit:
                let exitFrame = frameTool
                NSColor.yellowColor().setStroke()
                
                NSBezierPath(rect: exitFrame).stroke()
                let str = NSString(string:"Exit")
                let attrs : [String : AnyObject] = [
                    NSFontAttributeName: NSFont(name: "Courier", size: 10)!,
                    NSForegroundColorAttributeName: NSColor.whiteColor()
                ]
                str.drawInRect(NSRect(x: exitFrame.origin.x + 4, y: exitFrame.origin.y - 7, width: exitFrame.width, height: exitFrame.height), withAttributes: attrs)
        case tools.simple:
            let sempliceFrame = frameTool
            //Operazione Semplice
            NSColor.greenColor().setStroke()
            NSBezierPath(rect: sempliceFrame).stroke()
            let str = NSString(string:"*n")
            let attrs = [
                NSFontAttributeName: NSFont(name: "Courier", size: 17)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: sempliceFrame.origin.x + 6, y: sempliceFrame.origin.y - 7, width: sempliceFrame.width, height: sempliceFrame.height), withAttributes: attrs)
        case tools.oneShot:
            let oneShotFrame = frameTool
            //Operazione oneshot
            NSColor.blueColor().setStroke()
            NSBezierPath(rect: oneShotFrame).stroke()
            let str = NSString(string:"/n")
            let attrs = [
                NSFontAttributeName: NSFont(name: "Courier", size: 17)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: oneShotFrame.origin.x + 6, y: oneShotFrame.origin.y - 7, width: oneShotFrame.width, height: oneShotFrame.height), withAttributes: attrs)
        case tools.block:
            //Operazione oneshot
            NSColor.darkGrayColor().setFill()
            NSBezierPath(rect: frameTool).fill()
            
        case tools.clear:
            //Operazione oneshot
            NSColor.whiteColor().setFill()
            NSBezierPath(rect: frameTool).fill()
            
        case tools.startPosition:
            let exitFrame = frameTool
            NSColor.orangeColor().setStroke()
            
            NSBezierPath(rect: exitFrame).stroke()
            let str = NSString(string:"YOU")
            let attrs : [String : AnyObject] = [
                NSFontAttributeName: NSFont(name: "Courier", size: 12)!,
                NSForegroundColorAttributeName: NSColor.whiteColor()
            ]
            str.drawInRect(NSRect(x: exitFrame.origin.x + 3, y: exitFrame.origin.y - 7, width: exitFrame.width, height: exitFrame.height), withAttributes: attrs)
            default:
                break
        }
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        window!.movableByWindowBackground = false
        mouseOver = true
        if selectedTool != tools.null && selectedTool != tools.editCell{
            NSCursor.hide()
        }
    }
    
    override func mouseExited(theEvent: NSEvent) {
        window!.movableByWindowBackground = true
        mouseOver = false
        NSCursor.unhide()
    }
    
    override func mouseDown(theEvent: NSEvent){
        mouseDown = true
        mouseDownPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mtx.invert()
        let pt2level = mtx.transformPoint(mouseUpPt)
        mtx.invert()
            
        switch selectedTool{
            case tools.pan:
                ultimoPuntoTraslato = mouseDownPt
            case tools.editCell:
                let x = Int(floor(pt2level.x))/40
                let y = Int(floor(pt2level.y))/40
                if pt2level.x > 0 && pt2level.y > 0 && x < level.width && y < level.height {
                if level.map[x][y].type != .null{
                    let tvFrame = NSRect(x: mousePosition.x, y: mousePosition.y, width: 40, height: 20)
                    let tv = TextViewEditCell(frame: tvFrame)
                    tv.selectable = true
                    tv.stringValue = "0"
                    tv.editable = true
                    self.addSubview(tv)
                    tv.cella = NSMakePoint(pt2level.x/40, pt2level.y/40)
                    tv.level = self.level
                    selectedTool = tools.null
                }
                }
            default:
                break
        }
        if selectedTool != tools.pan{
            saveLevelInput?.textColor = NSColor.redColor()
        }
            
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        mouseUpPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        switch selectedTool{
        case tools.pan:
            mtx.translateXBy((-ultimoPuntoTraslato.x + mousePosition.x), yBy: -ultimoPuntoTraslato.y + mousePosition.y)
            ultimoPuntoTraslato = mousePosition
        case tools.block:
            mtx.invert()
            let pt2level = mtx.transformPoint(mouseUpPt)
            let x = Int(floor(pt2level.x))/40
            let y = Int(floor(pt2level.y))/40
            if !(x < 0 || x > level.width - 1 || y < 0 || y > level.height - 1){
                level.addCell(tools.block, x: x, y: y)
            }
            mtx.invert()
        case tools.clear:
            mtx.invert()
            let pt2level = mtx.transformPoint(mouseUpPt)
            mtx.invert()
            if pt2level.x > 0 && pt2level.y > 0{
                let x = Int(floor(pt2level.x))/40
                let y = Int(floor(pt2level.y))/40
                if !(x > level.width - 1 || y > level.height - 1){
                    level.addCell(tools.clear, x: Int(floor(pt2level.x))/40, y: Int(floor(pt2level.y))/40)
                }
            }
            

        default:
            break
        }
        self.needsDisplay = true
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        self.needsDisplay = true
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        mouseDown = false
        mousePosition = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mouseUpPt = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        mtx.invert()
        let pt2level = mtx.transformPoint(mouseUpPt)
        mtx.invert()
        let x = Int(floor(pt2level.x))/40
        let y = Int(floor(pt2level.y))/40
        if pt2level.x > 0 && pt2level.y > 0 && x < level.width && y < level.height {
        
        switch selectedTool{
            case tools.conditional:
                level.addCell(tools.conditional, x: x, y: y)
                let tvFrame = NSRect(x: mousePosition.x, y: mousePosition.y, width: 40, height: 20)
                let tv = TextViewEditCell(frame: tvFrame)
                tv.selectable = true
                tv.stringValue = ">0"
                tv.editable = true
                self.addSubview(tv)
                tv.cella = NSMakePoint(pt2level.x/40, pt2level.y/40)
                tv.level = self.level
            
            case tools.exit:
                level.addCell(tools.exit, x: x, y: y)
            
            case tools.block:
                level.addCell(tools.block, x: x, y: y)
            
            case tools.clear:
                level.addCell(tools.clear, x: x, y: y)
            case tools.oneShot:
                level.addCell(tools.oneShot, x: x, y: y)
                let tvFrame = NSRect(x: mousePosition.x, y: mousePosition.y, width: 40, height: 20)
                let tv = TextViewEditCell(frame: tvFrame)
                tv.selectable = true
                tv.stringValue = "*0"
                tv.editable = true
                self.addSubview(tv)
                tv.cella = NSMakePoint(pt2level.x/40, pt2level.y/40)
                tv.level = self.level

            case tools.simple:
                level.addCell(tools.simple, x: x, y: y)
                
                let tvFrame = NSRect(x: mousePosition.x, y: mousePosition.y, width: 40, height: 20)
                let tv = TextViewEditCell(frame: tvFrame)
                tv.selectable = true
                tv.stringValue = "+0"
                tv.editable = true
                self.addSubview(tv)
                tv.cella = NSMakePoint(pt2level.x/40, pt2level.y/40)
                tv.level = self.level

            case tools.startPosition:
                level.addCell(tools.startPosition, x: x, y: y)
            
                let tvFrame = NSRect(x: mousePosition.x, y: mousePosition.y, width: 40, height: 20)
                let tv = TextViewEditCell(frame: tvFrame)
                tv.selectable = true
                tv.stringValue = "3"
                tv.editable = true
                self.addSubview(tv)
                tv.cella = NSMakePoint(pt2level.x/40, pt2level.y/40)
                tv.level = self.level
            default:
                break
        }
        }
    }

}
