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
        else if type == tools.startPosition{
            value = "5"
        }
        else{
            value = "*2"
        }
    }
    
    init(type: tools = tools.null, value : String){
        self.type = type
        self.value = value
    }
}

class Level {
    
    var width:Int = 0
    var height:Int = 0
    var number : Int = 0
    var name : String? = nil
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
        self.number = totalLevel + 1
    }
    
    init(str: NSString){
        let a = str.componentsSeparatedByString("\n")
        name = a[0]
        let n = a[1].componentsSeparatedByString(" ")
        width = Int(n[2])! - Int(n[0])! + 1
        height = Int(n[1])! - Int(n[3])! + 1
        for(var i = 0; i<width; i++){
            map.append([])
        }
        for(var i = height-1; i>=0; i--){
            let column = a[i+2].componentsSeparatedByString(" ")
            for(var j = 0; j < width; j++){
                let cellstr = column[j]
                switch cellstr[0]{
                    case "B":
                        map[j].append(Cell(type: tools.block))
                    case "I":
                        map[j].append(Cell(type: tools.startPosition, value: (cellstr as NSString).substringFromIndex(1)))
                    case "N":
                        map[j].append(Cell())
                    case "S":
                        map[j].append(Cell(type: tools.simple, value: (cellstr as NSString).substringFromIndex(1)))
                    case "O":
                        map[j].append(Cell(type: tools.oneShot, value: (cellstr as NSString).substringFromIndex(1)))
                    case "E":
                        map[j].append(Cell(type: tools.exit))
                    case "C":
                        map[j].append(Cell(type: tools.conditional, value: (cellstr as NSString).substringFromIndex(1)))
                    default:
                        map[j].append(Cell())
                }
            }
        }
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
                    let str = NSString(string: String(map[i][j].value))
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
    
    func columnIsNull(i: Int) -> Bool{
        for(var j = 0; j<height; j++){
            if map[i][j].type != tools.null {
                return false;
            }
        }
        return true;
    }
    func rowIsNull(i: Int) -> Bool{
        for(var j=0; j<width; j++){
            if map[j][i].type != .null {
                return false
            }
        }
        return true
    }
    
    func saveOnFile(name1: String){
        if name1.isEmpty {
            self.name = "Default Name"
        }
        else{
            self.name = name1
        }
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            //Analisi dimensionale
            //(0,0) = in basso a sx
            //(width, height) = in alto a destra
            //Map è salvata per [colonna][riga]
            var topsx : (x: Int,y: Int) = (0,self.height)
            var bottomdx : (x: Int,y: Int) = (self.width,0)
            //Conta le colonne vuote prima
            for(var i=0; i<self.width; i++){
                if self.columnIsNull(i) {
                    topsx.x++
                } else{ break }
            }
            //Conta le colonne vuote dopo
            for(var i=self.width-1; i != 0; i--){
                if self.columnIsNull(i) {
                    bottomdx.x--
                } else { bottomdx.x--; break }
            }
            //Conta le righe vuote sotto
            for(var i=0; i<self.height; i++){
                if self.rowIsNull(i) {
                    bottomdx.y++
                }
                else{
                    break
                }
            }
            
            //Conta le righe vuote s
            for(var i=self.height-1; i != 0; i--){
                if self.rowIsNull(i) {
                    topsx.y--
                }
                else{
                    topsx.y--
                    break
                }
            }
            
            var str = self.name!
            str += "\n"+String(topsx.x)+" "+String(topsx.y) + " "+String(bottomdx.x)+" "+String(bottomdx.y)+"\n"
            for(var j = topsx.y; j>=bottomdx.y; j--){
                for(var i = topsx.x; i<=bottomdx.x; i++){
                    switch self.map[i][j].type{
                    case .null:
                        str += "N"+" "
                    case .simple:
                        str += "S"+self.map[i][j].value+" "
                    case .oneShot:
                        str += "O"+self.map[i][j].value+" "
                    case .block:
                        str += "B"+" "
                    case .conditional:
                        str += "C"+self.map[i][j].value+" "
                    case .exit:
                        str += "E"+" "
                    case .startPosition:
                        str += "I"+self.map[i][j].value+" "
                    default:
                        str += "?"+" "
                    }
                }
                str += "\n"
            }
            
            //If la cartella non esiste
            let home = NSHomeDirectory()
            let dataPath = home.stringByAppendingString("/MathLabyrinth")
            if(!NSFileManager.defaultManager().fileExistsAtPath(dataPath)){
                do{   try NSFileManager.defaultManager().createDirectoryAtPath(dataPath, withIntermediateDirectories: false, attributes: nil)
                }
                catch let error as NSError{
                    Swift.print(error)
                }
            }
            
            do{
                try str.writeToFile(dataPath.stringByAppendingString("/"+String(self.number)+".level"), atomically: true, encoding: NSUTF8StringEncoding)
            } catch let e as NSError{
                Swift.print(e)
            }
            
            levels.addObject(self.name!)
        }
    }

}