//
//  ScrollLevel.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 09/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class ScrollLevel: NSScrollView {
    
    override var acceptsFirstResponder: Bool {get {return true} }
    
    var scrollEnable : Bool = true
    
    override func awakeFromNib() {
        self.documentView = LevelView(frame: NSRect(origin: CGPoint.zero, size: self.frame.size))
        if self.frame.size.width > CGFloat((selectedLevel?.width)!*40) {
            scrollEnable = false
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func scrollWheel(theEvent: NSEvent) {
        if(scrollEnable){
            super.scrollWheel(theEvent)
            
        }
    }
    
    override func setFrameSize(newSize: NSSize) {
        super.setFrameSize(newSize)
        if self.frame.size.width > CGFloat((selectedLevel?.width)!*40) {
            scrollEnable = false
        }
        else{
            scrollEnable = true
        }
    }
    
}
