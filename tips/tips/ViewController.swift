//
//  ViewController.swift
//  tips
//
//  Created by Lee Edwards on 1/13/16.
//  Copyright © 2016 Lee Edwards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let lastUsedBillAmount = defaults.objectForKey("last_used_bill_amount") as! String
        billField.text = lastUsedBillAmount
    }
    
    override func viewWillDisappear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "last_used_bill_amount")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTipControlIndex = defaults.integerForKey("default_tip_amount_index")
        tipControl.selectedSegmentIndex = defaultTipControlIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        let first = billField.text!.startIndex

        if (billField.text == "") { billField.text = "0" }
        
        if (billField.text![first] == "0" && billField.text! != "0") {
            let withoutZero = billField.text!.startIndex.advancedBy(1)..<billField.text!.endIndex
            billField.text = billField.text![withoutZero]
        }

        let billAmount = Double(billField.text!)!
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

