//
//  LevelScrollController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 16/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class closeBtn: NSView{
        override func drawRect(dirtyRect: NSRect) {
            super.drawRect(dirtyRect)
            let pt = NSBezierPath()
            pt.moveToPoint(NSMakePoint(2, 2))
            pt.lineToPoint(NSMakePoint(self.frame.width / 2, 15))
            pt.lineToPoint(NSMakePoint(self.frame.width-2, 2))
            pt.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
            pt.lineWidth = 4
            NSColor.whiteColor().setStroke()
            pt.stroke()
        }
    
    override func mouseDown(theEvent: NSEvent) {
        let cont = self.superview?.superview as! LevelScrollController
        cont.dismissView()
    }
}

class MyScrollView: NSScrollView{
    
//    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
//        return true
//    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //super.contentView.copiesOnScroll = true
        self.addSubview(closeBtn(frame: NSRect(x: self.frame.width - 30, y: self.frame.height-25, width: 26, height: 18)))
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

    
}

class LevelScrollController: NSView {

    var scrollView: NSScrollView!
    
    override var acceptsFirstResponder: Bool {get {return true} }
//    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
//        return true
//    }
    //override func becomeFirstResponder() -> Bool { return true }
    
    var timer: NSTimer = NSTimer()
    var finalFrame:NSRect = NSRect.zero;
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    
        self.finalFrame = frameRect
        
        self.frame = NSRect(x: self.finalFrame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: 0)
        
        let f = frame
        let scrolledFrame = NSRect(x: 0, y: 0, width: f.size.width, height: 2500)
        let scrolledView = NSView(frame: scrolledFrame)
        
        // Inserisco pulsanti di esempio
        for i in 1 ... 50{
            let bt = LevelButton(frame: NSRect( x: 0,
                                                y: scrolledFrame.size.height -  CGFloat(i*50),
                                                width: scrolledView.frame.width,
                                                height: 50),
                                 name: "Primo Livello",
                                 number: 1)
            bt.becomeFirstResponder()
            scrolledView.addSubview(bt)
        }
        

     
        scrollView = MyScrollView(frame: NSRect(x: 0, y: 0, width: self.finalFrame.size.width, height: self.finalFrame.height))

        scrollView.drawsBackground = false
        
        scrollView.documentView = scrolledView
        scrollView.contentView.scrollToPoint((NSMakePoint(0, scrolledView.frame.size.height)))
        
        self.addSubview(scrollView)
        
//        //Si ruba lo scroll del mouse
//        let close = closeView(frame: NSRect(x: f.width - 24, y: 0, width: 24, height: 18))
//        self.addSubview(close)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "openFrameAnimation", userInfo: nil, repeats: true)

    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        self.window!.makeFirstResponder(self) //Riga maledetta. 4 ore per trovare questa cosa!
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
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        scrollView.drawRect(dirtyRect)
        NSColor.blackColor().setFill()
        
    }
    
    func dismissView(){
        NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "closeFrameAnimation", userInfo: nil, repeats: true)
        self.superview?.becomeFirstResponder()
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 0x35{
            dismissView()
        }
    }
}
