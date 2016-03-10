//
//  SaveTextInput.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 06/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class SaveTextInput: NSTextField {
    
    var level : Level? = nil
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func textDidChange(notification: NSNotification) {
        self.textColor = NSColor.redColor()
    }
    
    override func textDidEndEditing(obj: NSNotification) {
        super.textDidEndEditing(obj)
        if(textColor != NSColor.greenColor()){
            if(level!.saveOnFile(self.stringValue)){
                self.textColor = NSColor.greenColor()
            }
        }
    }
}
