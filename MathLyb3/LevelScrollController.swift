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
        let cont = self.superview?.superview as! MySheetView
        cont.dismissView()
    }
}

class MyScrollView: NSScrollView{
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool { return true }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

    
}


// Classe di gestione dell'intera vista
class LevelScrollController: MySheetView {

    var scrollView: NSScrollView! = nil
    var scrolledView : NSView! = nil
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    override func becomeFirstResponder() -> Bool { return true }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    
        self.finalFrame = frameRect
        
        self.frame = NSRect(x: self.finalFrame.origin.x, y: frame.origin.y+frame.height, width: frame.width, height: 0)
        
        let f = frame
        let height = CGFloat(50*levels.count) < self.frame.height ? self.frame.height : CGFloat(50*levels.count)
        let scrolledFrame = NSRect(x: 0, y: 0, width: f.size.width, height: height)
        scrolledView = NSView(frame: scrolledFrame)
        
        // Inserisco pulsanti di esempio
        let count = levels.count
        for(var i = 1; i<=count; i++){
            let bt = LevelButton(frame: NSRect( x: 0,
                                                y: scrolledFrame.size.height -  CGFloat(i*50),
                                                width: scrolledView.frame.width,
                                                height: 50),
                                 name: levels[i-1] as! NSString,
                                 number: i)
            scrolledView.addSubview(bt)
        }
        

        scrollView = MyScrollView(frame: NSRect(x: 0, y: 0, width: self.finalFrame.size.width, height: self.finalFrame.height))

        scrollView.drawsBackground = false
        
        scrollView.documentView = scrolledView
        scrollView.contentView.scrollToPoint((NSMakePoint(0, scrolledView.frame.size.height)))
        
        self.addSubview(scrollView)
        
//        //Si ruba lo scroll del mouse
//        let close = closeBtn(frame: NSRect(x: f.width - 24, y: 0, width: 24, height: 18))
//        self.addSubview(close)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        //self.window!.makeFirstResponder(self) //Riga maledetta. 4 ore per trovare questa cosa!
    }
    
    func updateFrame(frame: NSRect){
        
    }
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        scrollView.drawRect(dirtyRect)
        NSColor.blackColor().setFill()
        
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 0x35{
            dismissView()
        }
    }

}
