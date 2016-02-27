//
//  MyWindow.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class BorderlessWindow: NSWindow {
    
    override var canBecomeKeyWindow : Bool { return true }
    override var canBecomeMainWindow : Bool{ return true }
    
}
