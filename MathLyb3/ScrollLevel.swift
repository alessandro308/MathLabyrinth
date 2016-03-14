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
    var levelContainer : LevelView? = nil
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        levelContainer = LevelView(frame: NSRect(origin: CGPoint.zero /*NSMakePoint(-self.frame.origin.x, -self.frame.origin.y)*/, size: self.frame.size))
        levelContainer?.scrollView = self

        self.documentView = levelContainer
        NSApplication.sharedApplication().mainWindow!.makeFirstResponder(levelContainer)
        if self.frame.width > CGFloat((selectedLevel?.width)!*40) || self.frame.height > CGFloat((selectedLevel?.height)!*40){
            scrollEnable = false
        }
        
        self.horizontalScroller?.alphaValue = 0
        self.verticalScroller?.alphaValue = 0
        self.drawsBackground = false
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
       NSApplication.sharedApplication().mainWindow!.makeFirstResponder(levelContainer)
        return true
    }
    
    /*override func scrollWheel(theEvent: NSEvent) {
        if(scrollEnable){
            super.scrollWheel(theEvent)
        }
    }*/
    
}
