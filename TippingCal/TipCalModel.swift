//
//  TipCalModel.swift
//  TippingCal

//  Created by Anthony Washington on 8/10/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import Foundation


/* Model class for Tipping Calculator*/

class TipCalModel{

    private  var _tipAmount = 0.0
    private  var _totalBill = 0.0
    private  var _tipPercent = 0.0
    private  var _totalAmount = 0.0
    
    
    init(bA: Double, tP: Double){
        self._totalBill = bA
        self._tipPercent = tP
    }
    
    
    // Getter for _tipAmount
    var tip: Double{ return _tipAmount }
    
    // Getter method for _totalAmount
    var total: Double{ return _totalAmount }
    
    // Getter & Setter method for _totalBill
    var bill: Double{
        get { return _totalBill }
        set { _totalBill = newValue }
    }
    
    // Getter & Setter method for _tipPercent
    var percent: Double{
        get { return _tipPercent }
        set { _tipPercent = newValue }
    }
    
    
    // Compute tip value and total amount
    func calculateTip() {
        _tipAmount = percent * bill
        _totalAmount = bill + tip
    }

}