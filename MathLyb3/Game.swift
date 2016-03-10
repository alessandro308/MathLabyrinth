//
//  Game.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 09/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class Game: NSViewController {
    
    override var acceptsFirstResponder: Bool {get {return true} }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ws = NSScreen.mainScreen()?.frame.size
        let width : CGFloat = (ws?.width)!-100
        let height : CGFloat = (ws?.height)!-100
        self.view.frame = NSRect(origin: NSMakePoint(((ws?.width)!-width)/2, ((ws?.height)!-height)/2), size: CGSize(width:width, height:height))
    }
    
}
