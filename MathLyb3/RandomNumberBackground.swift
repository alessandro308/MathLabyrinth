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
    var previousFrame: NSRect = NSRect.zero
    
    var attrs: [String: AnyObject] = [
        NSFontAttributeName: NSFont(name: "Helvetica", size: 120)!,
        NSForegroundColorAttributeName: NSColor(calibratedWhite: 1, alpha: 0.7)
    ]
    
    override func awakeFromNib() {
        NSTimer.scheduledTimerWithTimeInterval(0.04, target: self, selector: "updateNumbers", userInfo: nil, repeats: true)
        previousFrame = self.frame
        for s in (0...5){
            chars.append(NSString(string: String(arc4random()) + String(arc4random()) + String(arc4random()) + String(arc4random()) ))
            strPosition.append(CGFloat(0))
            strVersus.append(CGFloat(-s%2))
            if(strVersus[s]%2 == 0){
                strPosition[s] = -chars[s].sizeWithAttributes(attrs).width+self.frame.size.width + 70
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onResize:", name: NSWindowDidResizeNotification, object: nil)
    }
    
    func onResize(notification: NSNotification){
        let size = self.window?.frame.size
        if(chars.count != 0){
            let y = chars[0].sizeWithAttributes(attrs).height / 2
            let x = CGFloat(chars.count)*y
            if(x < size?.height){
                chars.append(
                    NSString(string:
                        String(arc4random()) +
                        String(arc4random()) +
                        String(arc4random()) +
                        String(arc4random())
                    )
                )
                strPosition.append(CGFloat(0))
                strVersus.append(CGFloat(-(chars.count-1)%2))
                if(strVersus[(chars.count-1)]%2 == 0){
                    strPosition[(chars.count-1)] = -chars[(chars.count-1)].sizeWithAttributes(attrs).width+self.frame.size.width + 70
                }
                self.needsDisplay = true
            }
        }
        if size != nil {
            for s in (0...chars.count-1){
                if (strPosition[s] + chars[s].sizeWithAttributes(attrs).width < size!.width + 40) {
                    self.strPosition[s] = size!.width - chars[s].sizeWithAttributes(attrs).width + 40
                }

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

    
    override func mouseUp(theEvent: NSEvent) {
        if(theEvent.clickCount == 2 && self.window?.styleMask != (NSBorderlessWindowMask | NSResizableWindowMask | NSFullScreenWindowMask) ){
            self.previousFrame = (self.window?.frame)!
            self.window?.setFrame((NSScreen.mainScreen()?.frame)!, display: true, animate: true)
            self.window?.styleMask = NSBorderlessWindowMask | NSResizableWindowMask | NSFullScreenWindowMask
        }
        else if(theEvent.clickCount == 2){
            self.window?.setFrame(self.previousFrame, display:  true, animate: true)
            self.window?.styleMask = NSBorderlessWindowMask | NSResizableWindowMask
        }
        else{
            self.attrs[NSForegroundColorAttributeName] = NSColor.getColor(
                Int.random(1...100),
                now: self.attrs[NSForegroundColorAttributeName] as! NSColor)
            self.window?.viewsNeedDisplay = true
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        if(theEvent.keyCode == 53){
            NSApplication.sharedApplication().terminate(self)
        }
    }
    
}
