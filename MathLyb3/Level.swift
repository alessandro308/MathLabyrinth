//
//  Level.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 02/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Foundation
import Cocoa

enum coord{
    case N
    case E
    case W
    case S
}

class Parser{
    
    static func evalBool(n:String, x: String)->Bool{
        switch x[0]{
            case "=":
                return Int(n) == Int((x as NSString).substringFromIndex(1))
            case "<":
                return Int(n) < Int((x as NSString).substringFromIndex(1))
            case ">":
                return Int(n) > Int((x as NSString).substringFromIndex(1))
            default:
                return false
        }
    }
    
    static func evalArith(y:String, x: String)->String{
        let m = (x as NSString)
        let n = Int(y)
        if x.hasPrefix("+"){
            return String(n!+Int(m.substringFromIndex(1))!)
        }
        else if x.hasPrefix("-"){
            return String(n!-Int(m.substringFromIndex(1))!)
        }
        else if x.hasPrefix("**"){
            var pow = Int(m.substringFromIndex(2))!
            var res = 1
            while(pow > 0){
                res = res*n!
                pow--;
            }
            return String(res)
        }
        else if x.hasPrefix("/") || x.hasPrefix(":"){
            return String(n!/Int(m.substringFromIndex(1))!)
        }
        else if x.hasPrefix("%"){
            return String(n!%Int(m.substringFromIndex(1))!)
        }
        else if x.hasPrefix("*"){
            return String(n!*Int(m.substringFromIndex(1))!)
        }
        else{
            return "0";
        }
    }
    
}

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
    var restartMap : [[Cell]] = []
    
    var topsx : (x: Int,y: Int) = (0,0)
    var bottomdx : (x: Int,y: Int) = (0,0)
    
    var youPosition : (x: Int, y: Int) = (0,0)
    
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
        self.bottomdx = (x: 0, y:Int(height-1))
        self.topsx = (x: Int(width-1), y: 0)
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
            restartMap.append([])
        }
        for(var i = height-1; i>=0; i--){
            let column = a[i+2].componentsSeparatedByString(" ")
            for(var j = 0; j < width; j++){
                let cellstr = column[j]
                switch cellstr[0]{
                    case "B":
                        map[j].append(Cell(type: tools.block))
                        restartMap[j].append(Cell(type: tools.block))
                    case "I":
                        map[j].append(Cell(type: tools.startPosition, value: (cellstr as NSString).substringFromIndex(1)))
                        restartMap[j].append(Cell(type: tools.startPosition, value: (cellstr as NSString).substringFromIndex(1)))
                    case "N":
                        map[j].append(Cell())
                        restartMap[j].append(Cell())
                    case "S":
                        map[j].append(Cell(type: tools.simple, value: (cellstr as NSString).substringFromIndex(1)))
                        restartMap[j].append(Cell(type: tools.simple, value: (cellstr as NSString).substringFromIndex(1)))
                    case "O":
                        map[j].append(Cell(type: tools.oneShot, value: (cellstr as NSString).substringFromIndex(1)))
                        restartMap[j].append(Cell(type: tools.oneShot, value: (cellstr as NSString).substringFromIndex(1)))
                    case "E":
                        map[j].append(Cell(type: tools.exit))
                        restartMap[j].append(Cell(type: tools.exit))
                    case "C":
                        map[j].append(Cell(type: tools.conditional, value: (cellstr as NSString).substringFromIndex(1)))
                        restartMap[j].append(Cell(type: tools.conditional, value: (cellstr as NSString).substringFromIndex(1)))
                    default:
                        map[j].append(Cell())
                        restartMap[j].append(Cell())
                }
            }
        }
        for(var i = 0; i<width; i++){
            for(var j = 0; j < height; j++){
                if map[i][j].type == tools.startPosition{
                    youPosition = (i, j)
                }
            }
        }
    }

    func restart(){
        for(var i=0; i<width; i++){
            for(var j=0; j<height; j++){
                map[i][j] = Cell(type: restartMap[i][j].type, value: restartMap[i][j].value)
                if restartMap[i][j].type == tools.startPosition{
                    youPosition = (i, j)
                }
            }
        }
    }
    
    func addCell(t : tools, x:Int, y:Int){
        
        Swift.print(topsx, bottomdx)
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
        
        if(t != tools.clear){
            if(x<topsx.x){ topsx.x = x }
            if(x>bottomdx.x) { bottomdx.x = x}
            if(y>topsx.y){ topsx.y = y }
            if(y<bottomdx.y) { bottomdx.y = y }
        }
        else{
            //Controlla se non si è ristretto il livello
            while topsx.x < self.width && self.columnIsNull(topsx.x) {
                topsx.x++
            }
            while bottomdx.x >= 0 && self.columnIsNull(bottomdx.x) {
                bottomdx.x--
            }
            
            while topsx.y >= 0 && self.rowIsNull(topsx.y) {
                topsx.y--
            }
            while bottomdx.y < self.height && self.rowIsNull(bottomdx.y) {
                bottomdx.y++
            }
        }
    }
    
    func editCell(x:Int, y: Int, value:String){
        map[x][y].value = value
    }
    
    func draw(editMode:Bool = false){
        NSColor.whiteColor().setStroke()
        
        if(editMode){ //Draw grid
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
            
            NSColor.orangeColor().setStroke()
            let p = NSBezierPath(rect: NSRect(x: topsx.x*40, y: bottomdx.y*40, width: (bottomdx.x-topsx.x+1)*40, height: (topsx.y - bottomdx.y+1)*40))
            p.setLineDash([5.0, 5.0] , count: 2, phase: 0)
            p.lineWidth = 5
            p.stroke()
        }
        else{
            // TO DO: Draw background 
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
    
    func saveOnFile(name1: String) -> Bool{
        if !name1.isEmpty {
            self.name = name1
       
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            //Analisi dimensionale
            //(0,0) = in basso a sx
            //(width, height) = in alto a destra
            //Map è salvata per [colonna][riga]

            var str = self.name!
            str += "\n"+String(self.topsx.x)+" "+String(self.topsx.y) + " "+String(self.bottomdx.x)+" "+String(self.bottomdx.y)+"\n"
            for(var j = self.topsx.y; j>=self.bottomdx.y; j--){
                for(var i = self.topsx.x; i<=self.bottomdx.x; i++){
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
                levelsFile.setValue(String(self.number)+".level", forKey:  self.name!)
            } catch let e as NSError{
                Swift.print(e)
            }
            
            levels.addObject(self.name!)
        }
            return true;
        }
        return false;
    }
    
    func shake(x: coord){
        /*
            0
        3       1
            2
        */
        Swift.print("MURO")
    }
    
    
    /*
    ^Y
    |
    |
    | MAP INDEX
    |______> X
    
    */
    
    
    func move(newCell:(x: Int, y: Int), from: coord){
        let myValue = map[youPosition.x][youPosition.y].value
        if abs(Int(myValue)!)>10000{
            return;
        }
        if(newCell.y == height || newCell.y == -1 || newCell.x == -1 || newCell.x == width){ //Se sono all'ultima riga
            shake(from)
        }
        else{
            switch map[newCell.x][newCell.y].type{
            case tools.block:
                shake(from)
            case tools.conditional:
                if( Parser.evalBool(myValue, x: (map[newCell.x][newCell.y]).value) ){
                    switch from{
                        case .N:
                            map[newCell.x][newCell.y-1] = map[youPosition.x][youPosition.y]
                            map[youPosition.x][youPosition.y] = Cell()
                            youPosition = (newCell.x, newCell.y-1)
                        case .S:
                            map[newCell.x][newCell.y+1] = map[youPosition.x][youPosition.y]
                            map[youPosition.x][youPosition.y] = Cell()
                            youPosition = (newCell.x, newCell.y+1)
                        case .W:
                            map[newCell.x+1][newCell.y] = map[youPosition.x][youPosition.y]
                            map[youPosition.x][youPosition.y] = Cell()
                            youPosition = (newCell.x+1, newCell.y)
                        case .E:
                            map[newCell.x-1][newCell.y] = map[youPosition.x][youPosition.y]
                            map[youPosition.x][youPosition.y] = Cell()
                            youPosition = (newCell.x-1, newCell.y)
                    }
                    
                }
                else{
                    shake(from)
                }
                
            case tools.exit:
                break
            case tools.simple:
                let newCellValue = map[newCell.x][newCell.y].value
                let res = Parser.evalArith(myValue, x: newCellValue)
                
                map[newCell.x][newCell.y] = map[youPosition.x][youPosition.y]
                map[newCell.x][newCell.y].value = res
                
                map[youPosition.x][youPosition.y] = Cell()
                
                youPosition = newCell
                shake(from)
                
            case tools.oneShot:
                let newCellValue = map[newCell.x][newCell.y].value
                let res = Parser.evalArith(myValue, x: newCellValue)
                
                map[youPosition.x][youPosition.y].value = res
                //New position non viene aggiornato volutamente
                shake(from)
                
            case tools.null:
                map[newCell.x][newCell.y] = map[youPosition.x][youPosition.y]
                map[youPosition.x][youPosition.y] = Cell()
                
                youPosition = newCell
            default:
                break
            }
        }

    }
    
    
    func moveUp(){
        let newCell = (x: youPosition.x, y: youPosition.y+1)
        move(newCell, from: coord.S)
    }
    
    func moveRight(){
        let newCell = (x: youPosition.x+1, y: youPosition.y)
        move(newCell, from: coord.W)
    }
    
    func moveDown(){
        let newCell = (x: youPosition.x, y: youPosition.y-1)
        move(newCell, from: coord.N)
    }
    
    func moveLeft(){
        let newCell = (x: youPosition.x-1, y: youPosition.y)
        move(newCell, from: coord.E)
    }
}