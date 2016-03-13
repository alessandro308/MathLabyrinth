//
//  LevelMenu.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 13/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelMenu : NSView{
    var win = false
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let bSize = NSSize(width: 135, height: 35)
        
        let b = NSButton(frame: NSRect(x: (self.frame.width-bSize.width) / 2 , y: (self.frame.height-bSize.height)/2 + 35, width: bSize.width, height: bSize.height))
        b.setButtonType(NSButtonType.MomentaryPushInButton)
        b.bezelStyle = NSBezelStyle.RoundedBezelStyle
        b.alignment = .Center
        b.bordered = true
        b.title = "Menù principale"
        b.target = self
        b.action = "BackToMenu"
        self.addSubview(b)
        
        let b1Size = NSSize(width: 135, height: 35)
        
        let b1 = NSButton(frame: NSRect(x: (self.frame.width-b1Size.width) / 2  , y: (self.frame.height-b1Size.height)/2 - 15, width: b1Size.width, height: b1Size.height))
        b1.setButtonType(NSButtonType.MomentaryPushInButton)
        b1.bezelStyle = NSBezelStyle.RoundedBezelStyle
        b1.alignment = .Center
        b1.bordered = true
        b1.title = "Scegli livello"
        b1.target = self
        b1.action = "SelectLevel"
        self.addSubview(b1)
        
        let b3Size = NSSize(width: 80, height: 35)
        
        let b3 = NSButton(frame: NSRect(x: (self.frame.width-b3Size.width) / 2  , y: (self.frame.height-b3Size.height)/2 - 65, width: b3Size.width, height: b3Size.height))
        b3.setButtonType(NSButtonType.MomentaryPushInButton)
        b3.bezelStyle = NSBezelStyle.RoundedBezelStyle
        b3.alignment = .Center
        b3.bordered = true
        b3.title = "Esci"
        b3.target = self
        b3.action = "Exit"
        self.addSubview(b3)
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func BackToMenu(){
        let main = MainViewController()
        self.window?.contentViewController = main
        return;
    }
    
    func Exit(){
        NSApplication.sharedApplication().terminate(self)
    }
    
    func SelectLevel(){
        let f = self.frame
        let scr = LevelScrollController(frame: NSRect(x: f.size.width / 6 ,
            y: f.size.height - 270 ,
            width: f.size.width*4 / 6  ,
            height: 270))
        
        scr.becomeFirstResponder()
        
        self.addSubview(scr)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        NSColor(calibratedWhite: 0.1, alpha: 0.8).setFill()
        NSBezierPath(rect: NSRect(origin: CGPoint.zero, size: self.frame.size)).fill()
        
        if(win){
            let attrs: [String: AnyObject] = [
                NSFontAttributeName: NSFont(name: "CODE Bold", size: 120)!,
                NSForegroundColorAttributeName: NSColor(calibratedWhite: 1, alpha: 0.9)
            ]
            let text = NSString(string: "HAI VINTO!")
            let fontSize = text.sizeWithAttributes(attrs)
            text.drawAtPoint(NSMakePoint((self.frame.width-fontSize.width)/2, (self.frame.height-fontSize.height - 30)), withAttributes: attrs)
            NSColor.whiteColor().setStroke()
            let bz = NSBezierPath()
            bz.moveToPoint(NSMakePoint((self.frame.width-fontSize.width)/2, (self.frame.height-fontSize.height - 20)))
            Swift.print((self.frame.width-fontSize.width)/2)
            bz.lineToPoint(NSMakePoint(fontSize.width + (self.frame.width-fontSize.width)/2, (self.frame.height-fontSize.height - 20)))
            bz.stroke()
        }
        
        
        
        
    }
}
