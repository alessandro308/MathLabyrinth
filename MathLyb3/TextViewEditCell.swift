//
//  TextViewEditCell.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 06/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class TextViewEditCell: NSTextField {
    
    var level : Level? = nil
    var cella : NSPoint? = nil
    var eventMonitor1 : AnyObject? = nil
    var eventMonitor2 : AnyObject? = nil
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        eventMonitor1 = NSEvent.addLocalMonitorForEventsMatchingMask(NSEventMask.LeftMouseDownMask, handler: { (theEvent : NSEvent) -> NSEvent? in
            if !self.frame.contains(self.superview!.convertPoint(theEvent.locationInWindow, fromView: nil)) {
                self.superview?.becomeFirstResponder()
                self.removeFromSuperview()
                if self.eventMonitor1 != nil{
                    NSEvent.removeMonitor(self.eventMonitor1!)
                    self.eventMonitor1 = nil
                }
                if self.eventMonitor2 != nil{
                    NSEvent.removeMonitor(self.eventMonitor2!)
                    self.eventMonitor2 = nil
                }
            }
            return theEvent
        })
        eventMonitor2 = NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: { (theEvent: NSEvent) -> Void in
            if(theEvent.keyCode == 53){
                self.removeFromSuperview()
                if self.eventMonitor1 != nil{
                    NSEvent.removeMonitor(self.eventMonitor1!)
                    self.eventMonitor1 = nil
                }
                if self.eventMonitor2 != nil{
                    NSEvent.removeMonitor(self.eventMonitor2!)
                    self.eventMonitor2 = nil
                }
            }
            else if (theEvent.keyCode == 13){
                self.save()
            }
        })

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    override func textDidEndEditing(obj: NSNotification) {
        super.textDidEndEditing(obj)
        save()
    }
    
    func save(){
        if !self.stringValue.isEmpty{
        let ce = level!.map[Int(cella!.x)][Int(cella!.y)]
        if(ce.type == tools.conditional){
            if self.stringValue[0] == ">" || self.stringValue[0] == "<" || self.stringValue[0] == "=" {
                level!.editCell(Int(cella!.x), y: Int(cella!.y), value: (self.stringValue))
            }
        }
        else if(ce.type == tools.simple || ce.type == tools.oneShot){
            if self.stringValue[0] != ">" && self.stringValue[0] != "<" && self.stringValue[0] != "=" {
                level!.editCell(Int(cella!.x), y: Int(cella!.y), value: (self.stringValue))
            }
        }
        if(ce.type == tools.startPosition){
            if self.stringValue[0] == "0" || self.stringValue[0] == "1" || self.stringValue[0] == "2" || self.stringValue[0] == "3" || self.stringValue[0] == "4" || self.stringValue[0] == "5" || self.stringValue[0] == "6" || self.stringValue[0] == "7" || self.stringValue[0] == "8" || self.stringValue[0] == "9"{
                level!.editCell(Int(cella!.x), y: Int(cella!.y), value: (self.stringValue))
            }
        }
        self.removeFromSuperview()
        if self.eventMonitor1 != nil{
            NSEvent.removeMonitor(self.eventMonitor1!)
            self.eventMonitor1 = nil
        }
        if self.eventMonitor2 != nil{
            NSEvent.removeMonitor(self.eventMonitor2!)
            self.eventMonitor2 = nil
        }
        }
    }
    
}
