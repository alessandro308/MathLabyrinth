//
//  Level.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 02/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Foundation
import Cocoa

class Cell{
    
    var value : String = ""
    var type : tools = tools.null
    
    init(type: tools = tools.null){
        self.type = type
        if type == tools.conditional {
            value = "=1"
        }
        else{
            value = "*2"
        }
    }
}

class Level {
    
    var width:Int = 0
    var height:Int = 0
    
    var map : [[Cell]] = []
    
    init(width : CGFloat = 0, height : CGFloat = 0){
        for(var j : CGFloat = 0; j<width; j++){
            var x : [Cell] = []
            for(var i:CGFloat=0; i<height; i++){
                x.append(Cell())
            }
            map.append(x)
        }
        self.width = Int(width)
        self.height = Int(height)
    }
    
    func addFrame(rect: NSRect){
        
    }
    
    func addCell(t : tools, x:Int, y:Int){
        switch t{
            case tools.conditional:
                map[x][y] = Cell(type: tools.conditional)
            case tools.exit:
                //Check if exit already exists
                for(var i = 0; i<width; i++){
                    for(var j = 0; j<height; j++){
                        if(map[i][j].type == tools.exit){
                            map[i][j] = Cell()
                        }
                    }
                }
                map[x][y] = Cell(type: tools.exit)
            case tools.oneShot:
                map[x][y] = Cell(type: tools.oneShot)
            case tools.simple:
                map[x][y] = Cell(type:tools.simple)
            case tools.block:
                map[x][y] = Cell(type:tools.block)
            case tools.startPosition:
                //Check if start already exists
                for(var i = 0; i<width; i++){
                    for(var j = 0; j<height; j++){
                        if(map[i][j].type == tools.startPosition){
                            map[i][j] = Cell()
                        }
                    }
                }
                map[x][y] = Cell(type: tools.startPosition)
        case tools.clear:
                map[x][y] = Cell()
        default:
            break
        }
    }
    
    func editCell(x:Int, y: Int, value:String){
        map[x][y].value = value
    }
    
    func draw(editMode:Bool = false){
        NSColor.whiteColor().setStroke()
        if(editMode){
            for(var i = 0; i <= width; i++){
                let bz = NSBezierPath()
                bz.moveToPoint(NSPoint(x: i*40, y: 0))
                bz.lineToPoint(NSPoint(x: i*40, y: self.height*40))
                bz.stroke()
            }
            for(var i = height; i>=0; i--){
                let bz = NSBezierPath()
                bz.moveToPoint(NSPoint(x: 0, y: i*40))
                bz.lineToPoint(NSPoint(x: self.width*40, y: i*40))
                bz.stroke()
            }
        }
        let attrs = [
            NSFontAttributeName: NSFont(name: "Courier", size: 15)!,
            NSForegroundColorAttributeName: NSColor.whiteColor()
        ]
        for(var i = 0; i < width; i++){
            for(var j = height-1; j>=0; j--){
                switch map[i][j].type{
                    case tools.conditional:
                        let str = NSString(string: String(map[i][j].value))
                        let fontsize = str.sizeWithAttributes(attrs)
                        let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                        let strfr = NSRect(origin: NSMakePoint((CGFloat(i)*40)+20-fontsize.width/2, CGFloat(j)*40-fontsize.height/2), size: CGSize(width: 40, height: 40))
                        NSColor(red: 1, green: 0, blue: 0, alpha: 0.9).setFill()
                        NSBezierPath(rect: fr).fill()
                        str.drawInRect(strfr, withAttributes: attrs)
                    case tools.exit:
                        let str = "Exit"
                        let fontsize = str.sizeWithAttributes(attrs)
                        let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                        let strfr = NSRect(origin: NSMakePoint((CGFloat(i)*40)+20-fontsize.width/2, CGFloat(j)*40-fontsize.height/2), size: CGSize(width: 40, height: 40))
                        NSColor(hex: 0xcccc00, alpha: 0.9).setFill()
                        NSBezierPath(rect: fr).fill()
                        str.drawInRect(strfr, withAttributes: attrs)
                case tools.startPosition:
                    let str = "YOU"
                    let fontsize = str.sizeWithAttributes(attrs)
                    let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                    let strfr = NSRect(origin: NSMakePoint((CGFloat(i)*40)+20-fontsize.width/2, CGFloat(j)*40-fontsize.height/2), size: CGSize(width: 40, height: 40))
                    NSColor(hex: 0xFFA500, alpha: 0.9).setFill()
                    NSBezierPath(rect: fr).fill()
                    str.drawInRect(strfr, withAttributes: attrs)
                    
                    case tools.oneShot:
                        let str = NSString(string: String(map[i][j].value))
                        let fontsize = str.sizeWithAttributes(attrs)
                        let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                        let strfr = NSRect(origin: NSMakePoint((CGFloat(i)*40)+20-fontsize.width/2, CGFloat(j)*40-fontsize.height/2), size: CGSize(width: 40, height: 40))
                        NSColor(red: 0, green: 0, blue: 1, alpha: 0.9).setFill()
                        NSBezierPath(rect: fr).fill()
                        str.drawInRect(strfr, withAttributes: attrs)
                    case tools.simple:
                        let str = NSString(string: String(map[i][j].value))
                        let fontsize = str.sizeWithAttributes(attrs)
                        let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                        let strfr = NSRect(origin: NSMakePoint((CGFloat(i)*40)+20-fontsize.width/2, CGFloat(j)*40-fontsize.height/2), size: CGSize(width: 40, height: 40))
                        NSColor(hex: 0x2C6700, alpha: 0.9).setFill()
                        NSBezierPath(rect: fr).fill()
                        str.drawInRect(strfr, withAttributes: attrs)
                    
                    case tools.block:
                        let fr = NSRect(origin: NSMakePoint(CGFloat(i)*40, CGFloat(j)*40), size: CGSize(width: 40, height: 40))
                        NSColor.darkGrayColor().setFill()
                        NSBezierPath(rect: fr).fill()

                    default:
                        break
                }
            }
        }
    }

}