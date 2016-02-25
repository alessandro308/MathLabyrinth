//
//  RandomNumberBackground.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 22/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class RandomNumberBackground: NSView {
    
    override var acceptsFirstResponder: Bool {get {return true} }
    
    var chars: [NSString] = []
    var strPosition: [CGFloat] = []
    var strVersus: [CGFloat] = []

    var attrs: [String: AnyObject] = [
        NSFontAttributeName: NSFont(name: "Helvetica", size: 120)!,
        NSForegroundColorAttributeName: NSColor(calibratedWhite: 1, alpha: 0.7)
    ]
    
    override func awakeFromNib() {
        for s in (0...5){
            chars.append(NSString(string: String(arc4random()) + String(arc4random())))
            strPosition.append(CGFloat(0))
            strVersus.append(CGFloat(-s%2))
            if(strVersus[s]%2 == 0){
                strPosition[s] = -chars[s].sizeWithAttributes(attrs).width+self.frame.size.width + 70
            }
        }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        NSColor.blackColor().setFill()
        NSBezierPath(rect: self.frame).fill()

        //NSGraphicsContext.currentContext()?.shouldAntialias = false; //Attiva per disattivare antialias
        for s in (0...chars.count-1){
            let str = chars[s]
            let y1 = -str.sizeWithAttributes(attrs).height + CGFloat(s)*str.sizeWithAttributes(attrs).height/1.5
            let fontSize = str.sizeWithAttributes(attrs)
            str.drawInRect(NSRect(x: self.strPosition[s], y: y1, width: fontSize.width, height: fontSize.height), withAttributes: attrs)
        }
    }
    
    func updateNumbers(){
        for s in (0 ... chars.count-1){
            strPosition[s] += CGFloat(pow(-1.0, self.strVersus[s]))
            if(self.frame.width + abs(self.strPosition[s]) + 40 >= self.chars[s].sizeWithAttributes(attrs).width || self.strPosition[s] > 0){
                self.strVersus[s] = self.strVersus[s]+1 % 2
            }
        }
        self.needsDisplay = true
    }
    
    override func mouseDown(theEvent: NSEvent) {
        //let point = theEvent.locationInWindow
        self.attrs[NSForegroundColorAttributeName] = NSColor.getColor(
                                                            Int.random(1...100),
            now: self.attrs[NSForegroundColorAttributeName] as! NSColor)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.window?.viewsNeedDisplay = true
    }
    
    override func keyDown(theEvent: NSEvent) {
        if(theEvent.keyCode == 53){
            NSApplication.sharedApplication().terminate(self)
        }
    }
    
}
