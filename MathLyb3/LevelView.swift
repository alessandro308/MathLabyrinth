//
//  LevelView.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 09/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Cocoa

class LevelView: NSView {
    
    override var acceptsFirstResponder : Bool {get { return true } }
    var scrollView : NSScrollView? = nil
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        if self.frame.size.width < CGFloat((selectedLevel?.width)!*40){
            self.frame.size.width = CGFloat((selectedLevel?.width)!*40)
        }
        if self.frame.size.height < CGFloat((selectedLevel?.height)!*40){
            self.frame.size.height = CGFloat((selectedLevel?.height)!*40)
        }
        selectedLevel?.view = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func drawRect(dirtyRect: NSRect) {
        let offset = CGFloat(10)
        NSColor(calibratedWhite: 0, alpha: 0.4).setFill()
        let pt = NSBezierPath(rect: NSRect(x: 0+offset, y: 0+offset, width: self.frame.size.width-2*offset, height: self.frame.size.height-2*offset))
        pt.fill()
        self.alphaValue = 1
        NSColor(hex: 0xd6ecfa, alpha: 1).setStroke()
        let pt1 = NSBezierPath(rect: NSRect(x: 0+offset, y: 0+offset, width: self.frame.size.width-2*offset, height: self.frame.size.height-2*offset))
        pt1.lineJoinStyle = NSLineJoinStyle.RoundLineJoinStyle
        pt1.lineWidth = offset/2
        pt1.stroke()
        
        let levelWidth = CGFloat((selectedLevel?.width)! * 40)
        let levelHeight = CGFloat((selectedLevel?.height)!*40)
        //Centra il livello
        let mtx = NSAffineTransform()
        
        var deltax:CGFloat = 0
        var deltay:CGFloat = 0
        if levelWidth < self.frame.width{
            deltax = (self.frame.width-levelWidth)/2
        }
        if levelHeight < self.frame.height{
            deltay =  (self.frame.height-levelHeight)/2
        }
        
        mtx.translateXBy(deltax, yBy: deltay)
        mtx.concat()
        selectedLevel?.drawGame()
        
    }
    
    override func keyDown(theEvent: NSEvent) {
        let char = theEvent.keyCode
        if !(selectedLevel?.levelEnded)!{
        switch char {
        case 123:
            selectedLevel?.moveLeft()
        case 124:
            selectedLevel?.moveRight()
        case 125:
            selectedLevel?.moveDown()
        case 126:
            selectedLevel?.moveUp()
        default:
            break
        }
        }
        switch char{
        case 15:
            selectedLevel?.restart()
        case 53:
            // Show menù
            let main = MainViewController()
            self.window?.contentViewController = main
            return;
        default:
            Swift.print("Premuto tasto ",char)
        }

        if (selectedLevel?.levelEnded)!{
            levelEndedAnimation()
        }

        self.needsDisplay = true
    }
    
    
    func levelEndedAnimation(){
        let levelMenu = LevelMenu(frame: self.frame)
        levelMenu.win = true
        self.addSubview(levelMenu)
    }
    
}
