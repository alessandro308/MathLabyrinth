//
//  LevelMenu.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 13/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelMenu : NSView{
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let bSize = NSSize(width: 100, height: 20)
        let b = NSButton(frame: NSRect(x: (self.frame.width-bSize.width) / 2  , y: (self.frame.height-bSize.height)/2, width: bSize.width, height: bSize.height))
        b.setButtonType(NSButtonType.MomentaryPushInButton)
        b.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.addSubview(b)
        Swift.print(self.frame.origin, self.frame.size)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        NSColor.orangeColor().setFill()
        NSBezierPath(rect: NSRect(origin: CGPoint.zero, size: self.frame.size)).fill()
    }
}
