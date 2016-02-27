//
//  PlayGame.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 27/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class PlayGame: NSViewController {
    
    @IBOutlet var mainView: GameView!
    
    override var acceptsFirstResponder : Bool {get {return true} }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.becomeFirstResponder()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("MouseDown on NSViewController")
    }
}
