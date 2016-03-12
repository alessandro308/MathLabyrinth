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
    
    var composeLevelView:NSView? = nil
    var scr : LevelScrollController? = nil
    
    @IBOutlet var background: RandomNumberBackground!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet var blackRect: blackBackground!
    
    override func awakeFromNib() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onResize:", name: NSWindowDidResizeNotification, object: nil)
    }

    @IBAction func btnLevelClicked(sender: AnyObject) {
        let f = self.view.frame
        composeLevelView = nil
        scr = LevelScrollController(frame: NSRect(x: f.size.width / 6 ,
            y: f.size.height - 235 ,
            width: f.size.width*4 / 6  ,
            height: 270))
        
        scr!.becomeFirstResponder()
        
        self.view.addSubview(scr!)
    }

    @IBAction func newLevel(sender: AnyObject) {
        let f = self.view.frame
        if(scr != nil){
            scr?.dismissView()
            scr = nil
        }
        composeLevelView = CreateLevelController(frame: NSRect(x: f.size.width / 12 ,
            y: f.size.height / 20 ,
            width: f.size.width*5 / 6  ,
            height: f.size.height*18 / 20 ))
        composeLevelView!.becomeFirstResponder()
        self.view.addSubview(composeLevelView!)
    }

    @IBAction func ExitBtn(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    func onResize(notif : NSNotification){
        let f = self.view.frame
        if(composeLevelView != nil){
            composeLevelView!.frame = NSRect(x: f.size.width / 12 ,
                y: f.size.height / 20 ,
                width: f.size.width*5 / 6  ,
                height: f.size.height*18 / 20 )
            composeLevelView!.needsDisplay = true
        }
        if scr != nil{
            let x = scr!.frame.width/2
            scr!.setFrameOrigin(NSMakePoint(f.width/2-x, f.height - scr!.frame.height))
            scr!.needsDisplay = true
        }
        
        
    }
    
}
