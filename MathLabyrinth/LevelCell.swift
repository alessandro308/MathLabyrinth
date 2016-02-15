//
//  LevelCell.swift
//  MathLabyrinth
//
//  Created by Alessandro Pagiaro on 15/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelCell: NSView {

    var name: String = "Livello"
    var number: Int = 0

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        NSBezierPath(rect: NSRect(x: 0, y: 0, width: (self.superview?.frame.size.width)!, height: 30)).fill()
        
    }
    
}
