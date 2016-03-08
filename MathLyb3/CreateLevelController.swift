//
//  CreateLevelController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class closeEditLevel: NSView{
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let pt = NSBezierPath()
        pt.moveToPoint(NSMakePoint(2, 2))
        pt.lineToPoint(NSMakePoint(self.frame.width / 2, 15))
        pt.lineToPoint(NSMakePoint(self.frame.width-2, 2))
        pt.lineCapStyle = NSLineCapStyle.RoundLineCapStyle
        pt.lineWidth = 2
        NSColor.whiteColor().setStroke()
        pt.stroke()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let cont = self.superview as! MySheetView
        cont.dismissView()
    }
}

class CreateLevelController: MySheetView {

    var canvas:CustomLevel? = nil;
    var toolbar: Toolbar? = nil;
    let toolbarWidth:CGFloat = 40
    var btn : closeEditLevel? = nil;
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        outClickClose = false
        let canvasFrame = NSRect(x: 0, y: 0, width: self.frame.width - toolbarWidth, height: self.finalFrame.height)
        canvas = CustomLevel(frame:canvasFrame)
        self.addSubview(canvas!)
        toolbar = Toolbar(frame: NSRect(x: self.frame.width - toolbarWidth, y:0, width: toolbarWidth, height: self.finalFrame.height ))
        self.addSubview(toolbar!)
        
        btn = closeEditLevel(frame: NSRect(origin: NSMakePoint(10, self.finalFrame.height - 30), size: CGSize(width: 30,height: 30)))
        btn?.becomeFirstResponder()
        self.addSubview(btn!)
        
        //TrackingArea for canvas
        let options : NSTrackingAreaOptions = [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.InVisibleRect, NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.MouseMoved]
        let trk = NSTrackingArea(rect: canvasFrame, options: options, owner: canvas, userInfo: nil)
        canvas?.addTrackingArea(trk)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onResize:", name: NSWindowDidResizeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        canvas = CustomLevel(frame: NSRect(x: 0, y: 0, width: self.frame.width - toolbarWidth, height: self.frame.height))
    }
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    func updateContentSize(){
        canvas!.setFrameSize( NSSize(width: self.frame.width - toolbarWidth, height: self.frame.height) )
        toolbar!.setFrameSize( NSSize(width: toolbarWidth, height: self.frame.height) )
        toolbar!.setFrameOrigin( NSMakePoint(self.frame.width - toolbarWidth, 0 ))
        btn!.setFrameOrigin(NSMakePoint(10, self.frame.height - 30))
    }

    func onResize(theEvent : NSEvent){
        updateContentSize()
    }
    
    override func dismissView() {
        super.dismissView()
        totalLevel++
    }
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 53{
            self.dismissView()
        }
    }
    
}
