//
//  GameController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 11/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class GameController: NSView {
    
    override var acceptsFirstResponder : Bool {get { return true } }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let svSize = self.frame.size
        let scrollView = ScrollLevel(frame: NSRect(origin: NSMakePoint((self.frame.width-svSize.width)/CGFloat(2), (self.frame.height - svSize.height)/CGFloat(2)), size: svSize))
        self.addSubview(scrollView)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
