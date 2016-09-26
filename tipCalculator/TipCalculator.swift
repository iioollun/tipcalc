//
//  TipCalculator.swift
//  tipCalculator
//
//  Created by Un on 9/23/16.
//  Copyright © 2016 Un. All rights reserved.
//

import Foundation

class TipCalculator{
    var bill: Float = 0
    var tip: Float = 0
    var split: Int = 0
    var tipAmount: Float = 0
    var totalAmount: Float = 0
    var resultSplit: Float = 0
    
    init(bill: Float, tip: Float, split: Int) {
        self.bill = bill
        self.tip = tip
        self.split = split
    }
    
    func calculator(){
        self.tipAmount = self.bill * self.tip
        self.totalAmount = self.tipAmount + self.bill
        self.resultSplit = self.totalAmount / Float(self.split)
    }
    
}
