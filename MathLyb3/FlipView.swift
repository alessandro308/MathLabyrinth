//
//  FlipView.swift
//  MathLyb3
//
//  Created by Alessandro Pagiaro on 12/03/16.
//  Copyright © 2016 Alessandro Pagiaro. All rights reserved.
//

import Foundation
import Quartz

public class mbFliperViews : NSObject {
    let views : NSMutableArray;
    let superView: NSView? = nil; // Super view
    let idxActiveView : NSInteger?;
    let idxBefore : NSInteger? = nil;
    let origin: CGPoint; // origin for views
    let prespect : NSInteger; // перспектива
    let time : Double;
    
    override init(){
        views = []
        idxActiveView = -1
        prespect = -1000
        origin = NSMakePoint(0, 0)
        time = 1.0
        super.init()
    }
    
    func laterForView(view : NSView){
        view.wantsLayer = false
        view.layer = nil
        let newLayer = CALayer.layer()
        
    }
}