//
//  globalVar.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 23/02/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Foundation
import Cocoa

var selectedLevel = -1;


func nc() -> CGFloat{
    return CGFloat(Int.random(0...100))/100
    //print(n)
}
infix operator ^^ { }
func ^^ (radix: CGFloat, power: CGFloat) -> CGFloat {
    return CGFloat(pow(Double(radix), Double(power)))
}
extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    var red: CGFloat {
        return CGFloat((self & 0xFF0000) >> 16) / 255.0
    }
    var green: CGFloat {
        return CGFloat((self & 0x00FF00) >> 8) / 255.0
    }
    var blue: CGFloat {
        return CGFloat(self & 0x00FF) / 255.0
    }
}

extension NSColor
{
    static func getColor(i: Int, now: NSColor) -> NSColor{
        let alpha = CGFloat(0.6)
        let dict: [NSColor] = [
            NSColor(calibratedRed: CGFloat(241)/255, green: CGFloat(107)/255, blue: CGFloat(111)/255, alpha: alpha),
            NSColor(calibratedRed: CGFloat(197)/255, green: CGFloat(198)/255, blue: CGFloat(182)/255, alpha: alpha),
            NSColor(calibratedRed: CGFloat(170)/255, green: CGFloat(205)/255, blue: CGFloat(110)/255, alpha: alpha),
            //NSColor(calibratedRed: CGFloat(60)/255, green: CGFloat(53)/255, blue: CGFloat(48)/255, alpha: 1),
            NSColor(hex: 0xd6ecfa),
            NSColor(hex: 0xf15c5c),
            NSColor(hex: 0xb84a39),
            //NSColor(hex: 0x6f3826)
        ]
        if(dict[i%dict.count] == now){
            return dict[(i+1)%dict.count];
        }
        return dict[i%dict.count];
    }
    
    convenience init(hex: Int, alpha: CGFloat = 0.6) {
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: alpha)
    }
}
