//
//  MenuBtn.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 26/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class MenuBtn: NSButton {
    let attrs : [String: AnyObject] = [
        NSFontAttributeName: NSFont(name: "Helvetica", size: 30)!,
        NSForegroundColorAttributeName: NSColor.whiteColor()
    ]
    
    override func awakeFromNib() {
        self.frame = NSRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: 30)
    }
    override func drawRect(dirtyRect: NSRect) {
        
        NSString(string:self.title).drawInRect(NSRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), withAttributes: attrs)
    }
    
}
