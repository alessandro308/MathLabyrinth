//
//  GameViewController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 11/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.styleMask = ( NSBorderlessWindowMask | NSResizableWindowMask & NSFullScreenWindowMask)
    }

    
}
