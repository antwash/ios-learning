//
//  ViewController.swift
//  TippingCal
//
//  Created by Anthony Washington on 8/10/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlets
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipPercentSlider: UISlider!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    // MARK: - @Properties
    var tipModel = TipCalModel(bA: 0.0, tP: 0.0)
    
    
    // MARK: - @Initialize Views
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUserInterface()
    }

    
    // MARK: - @IBActions
    
    @IBAction func billAmountChange(sender: AnyObject) {
        self.calculateTip()
    }
    
    @IBAction func tipSliderChange(sender: AnyObject) {
        self.calculateTip()
    }
    
    // MARK: - Functions
    
    //(TODO): Add alert if multiple decimals entered
    //(TODO): Fix bill amount text field UI limitations
    func calculateTip(){
        tipModel.percent = Double(tipPercentSlider.value)
        tipModel.bill = ((billLabel.text)! as NSString).doubleValue
        tipModel.calculateTip()
        self.updateUserInterface()
    }
    
    // updates user interface
    func updateUserInterface() {
        self.tipPercentLabel.text = "Tip \(Int(tipPercentSlider.value * 100))%"
        self.tipAmountLabel.text = String(format: "$%0.2f", tipModel.tip)
        self.totalAmountLabel.text = String(format: "$%0.2f", tipModel.total)
    }
}

