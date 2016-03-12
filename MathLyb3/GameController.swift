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
        
        //self.view.window?.setFrame(NSRect(origin: NSMakePoint(((ws?.width)!-width)/2, ((ws?.height)!-height)/2), size: CGSize(width:width, height:height)), display: true, animate: true)
        
        let bg = RandomNumberBackground(frame: NSRect(origin: CGPoint.zero, size: self.frame.size))
        self.addSubview(bg)
        self.addConstraint(NSLayoutConstraint(item: bg, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: bg, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: bg, attribute: NSLayoutAttribute.Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: bg, attribute: NSLayoutAttribute.Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))

        let svSize = NSSize(width: 800, height: 460)
        let scrollView = ScrollLevel(frame: NSRect(origin: NSMakePoint((self.frame.width-svSize.width)/CGFloat(2), (self.frame.height - svSize.height)/CGFloat(2)), size: svSize))
        self.addSubview(scrollView)
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        scrollView.becomeFirstResponder()

 }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
