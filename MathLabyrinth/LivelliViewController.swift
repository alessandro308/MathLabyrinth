//
//  LivelliViewController.swift
//  MathLabyrinth
//
//  Created by Alessandro Pagiaro on 15/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LivelliViewController: NSViewController {

    @IBOutlet var scrollView: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollWidth = self.scrollView.frame.size.width
        let scrollContainer = NSView(frame: NSRect(x: 0, y: 0, width:scrollWidth, height: 400))
        
        // Aggiungo una riga di Livello
        scrollContainer.addSubview(LevelCell(frame: NSRect(x: 0, y: 0, width: scrollWidth, height: 30)))
        
        scrollView.documentView = scrollContainer
        
    }
    
}
