//
//  Stages.swift
//  
//
//  Created by Steven Lipton on 7/29/20.
//
// The model for the complication stages.

import UIKit

///The model for the complications. Has methods  to generate the stages of pizza making and delivery.
struct Stages{
    
    //Basic arrays with the stages data
    private let text = ["Order a pizza","Order Processing","Preparing Order","Delivering Order", "Enjoy"]
    private let emoji = ["🍕","📩","🧑🏽‍🍳","🚚", "🥰"]
    private let times = [0,2.0,10.0,15.0,20.0,25.0]
    private let systemImages = ["arrow.up.doc.fill","text.badge.checkmark","chart.pie.fill","car","heart"]
    
    var count:Int{text.count}
    /// Computes total time for the order.
    var totalTime:Double{
        var total = 0.0
        for time in times{ total += Double(time) }
        return total
    }
    func isStage(_ stage:Int)->Bool{
        return stage >= 0 && stage < text.count
    }
    
    //Getters
    
    /// Returns a text description of the stage
    func text(_ stage:Int)->String{
        return isStage(stage) ? text[stage] : text[0]
    }
    
    ///Returns a emoji description of the stage
    func emoji(_ stage:Int)->String{
        return isStage(stage) ? emoji[stage] : emoji[0]
    }
    ///Returns the interval the stage
    func times(_ stage:Int)->TimeInterval{
        return isStage(stage) ? times[stage] : 0.0
    }
    
    ///Returns a SFSymbol description of the stage
    /// - If not found return a Sfsymbol of the stage. if out of bounds returns a stage in a square.
    func symbol(_ stage:Int)->UIImage{
        if isStage(stage) {
            return UIImage(systemName:systemImages[stage]) ?? UIImage(systemName:"\(stage).circle")!
        }  else{
           return  UIImage(systemName:"\(stage).square.fill")!
        }
    }
    
    func timeLineEnd(seconds:Double)->Double{
        if let lastTime = times.last{
            return lastTime + seconds
        }
        return 0
    }
    
    //convenience method for figuring percent done from the stage.
    func fillFraction(stage:Int)-> Float{
        let value:Float = ((count >= stage) ? Float(stage)/Float(count - 1) : 0.0)
        return value
    }
}
