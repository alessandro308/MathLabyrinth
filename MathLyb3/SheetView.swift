//
//  CreateLevelController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class MySheetView: NSView {
    override var acceptsFirstResponder: Bool {get {return true} }
    
    var timer: NSTimer = NSTimer()
    var finalFrame:NSRect = NSRect.zero;
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.finalFrame = frameRect
        
        self.frame = NSRect(x: self.finalFrame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: 0)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "openFrameAnimation", userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func closeFrameAnimation(){
        self.frame = NSRect(x: self.frame.origin.x,
            y: self.frame.origin.y + 12,
            width: self.frame.width,
            height: self.frame.height - 12)
        if(self.frame.height <= 0){
            timer.invalidate()
            self.removeFromSuperview()
        }
        if(selectedLevel != -1){
            self.window?.contentViewController = PlayGame()
        }
    }
    
    func openFrameAnimation(){
        self.frame = NSRect(x: self.frame.origin.x,
            y: self.frame.origin.y-12,
            width: self.frame.width,
            height: self.frame.height + 12)
        if(self.frame.height >= self.finalFrame.height){
            self.frame = self.finalFrame
            timer.invalidate()
        }
        self.needsDisplay = true
    }
    
    func dismissView(){
        NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "closeFrameAnimation", userInfo: nil, repeats: true)
        self.superview?.becomeFirstResponder()
    }
    
}
