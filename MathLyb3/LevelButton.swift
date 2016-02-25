//
//  LevelButton.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 16/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class ScrolledString: NSView{
    var text: NSString;
    override var acceptsFirstResponder:Bool{ get {return true} }
    
    init(frame frameRect: NSRect, string:NSString){
        self.text = NSString(string:string )
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        self.text = NSString(string: "ciao")
        super.init(coder:coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let font = NSFont(name: "Helvetica", size: 40.0)
        let attrs : [String: AnyObject] = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: NSColor.whiteColor()
        ]
        text.drawInRect(NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), withAttributes: attrs)
        //NSBezierPath(rect: NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).fill()
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        Swift.print("MouseMOVED on ScrolledString")
    }

}

class LevelButton: NSButton {
    override var acceptsFirstResponder: Bool {get {return false} }
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }

    var name:NSString = "";
    var number: Int = 0
    var textColor = NSColor.whiteColor()
    var bgColor :NSColor = NSColor(hex: 0x6AAFE6, alpha: 0.95)
    var textcolor = NSColor.blackColor()
    var myRect: NSRect;
    
    required init(frame frameRect: NSRect, name: NSString, number: Int) {
        myRect = NSRect(x: 0, y: 0, width: frameRect.width-1, height: frameRect.height-1)
        super.init(frame: frameRect)
        self.number = number
        self.name = name

        let view = ScrolledString(frame: NSRect(x: myRect.width*4/9, y: 0, width: myRect.width*4/9 , height: myRect.height), string: self.name)
        view.text = self.name
        view.needsDisplay = true
        self.addSubview(view)
    }

    required init?(coder: NSCoder) {
        myRect = NSRect.zero
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        //Draw Number
        let font = NSFont(name: "Helvetica", size: 40.0)
        bgColor.setFill() //Azzurrino
        NSColor.blackColor().setStroke()
        let path = NSBezierPath(rect: myRect)
        path.fill()
        path.stroke()
        
        let attrs : [String: AnyObject] = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: textColor,
        ]
        let numberRect = NSRect(x: myRect.width / 18, y: 0, width: myRect.width*3/9, height: myRect.height)
        NSString(string: self.number < 10 ? "0"+String(self.number) : String(self.number)).drawInRect(numberRect, withAttributes: attrs)
        
        let pt = NSBezierPath()
        NSColor.whiteColor().setStroke()
        pt.moveToPoint(NSMakePoint(myRect.width*2/9, 10))
        pt.lineToPoint(NSMakePoint(myRect.width*2/9, myRect.height-10))
        pt.stroke()
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        self.bgColor = NSColor(hex: 0x4A7AA1)
        self.textColor = NSColor.darkGrayColor()
        self.needsDisplay = true
    }
    
    override func mouseUp(theEvent: NSEvent) {
        Swift.print("MouseUP on LevelButton")
        self.textColor = NSColor.whiteColor()
        self.bgColor = NSColor(hex: 0x6AAFE6, alpha: 0.95)
    }
}
