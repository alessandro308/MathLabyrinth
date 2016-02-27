//
//  MainViewController.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 16/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    override var acceptsFirstResponder: Bool { get {return true} }
    
    @IBOutlet var background: RandomNumberBackground!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        NSTimer.scheduledTimerWithTimeInterval(0.04, target: background, selector: "updateNumbers", userInfo: nil, repeats: true)
    }

    @IBAction func btnLevelClicked(sender: AnyObject) {
        let f = self.view.frame
        let scr = LevelScrollController(frame: NSRect(x: f.size.width / 6 ,
            y: f.size.height / 5 ,
            width: f.size.width*4 / 6  ,
            height: f.size.height*4 / 5 ))
        scr.becomeFirstResponder()
        self.view.addSubview(scr)
    }

    @IBAction func newLevel(sender: AnyObject) {
        let f = self.view.frame
        let composeLevelView = CreateLevelController(frame: NSRect(x: 0, y: 0, width: f.width, height: f.height))
        composeLevelView.becomeFirstResponder()
        self.view.addSubview(composeLevelView)
    }

}
