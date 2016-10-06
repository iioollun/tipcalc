//
//  TipCalculatorViewController.swift
//  tipCalculator
//
//  Created by Un on 9/23/16.
//  Copyright © 2016 Un. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
    // format number
    let fm = NumberFormatter()

    // MARK: - IBOutlet
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tipResultLabel: UILabel!
    
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var splitResultLabel: UILabel!
    
    // MARK: - Properties
    var tipCalc = TipCalculator(bill: 0, tip: 0.2, split: 1)
    
    // MARK: - View Controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        innitApp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        innitApp()
    }
    
    func innitApp(){
        
        let currentSymbol = getCurrencySymbol()
        fm.currencySymbol = currentSymbol
        fm.numberStyle = .currency
        
        // check default Settings
        
        let defaultSettings = UserDefaults.standard
        
        let checkDefaultTip = defaultSettings.object(forKey: "defaultTipSetting")
        let checkBillValue = defaultSettings.object(forKey: "billValue")
        
        // set default setting
        if checkDefaultTip == nil {
            // func in SettingViewController
            SettingViewController().updateSettings(defaultTip: 0.2, defaultSplit: 1)
        }
        
        if checkBillValue != nil {
            let billValue = defaultSettings.string(forKey: "billValue")
            let billTime = defaultSettings.double(forKey: "billTime")
            let currentTime = NSDate().timeIntervalSince1970
            if currentTime - billTime < 600 {
                billField.text = billValue
            }
        }
        
        // get default setting
        let defaultTip = defaultSettings.float(forKey: "defaultTipSetting")
        let defaultSplit = defaultSettings.integer(forKey: "defaultSplitSetting")
        let bill = Float(billField.text!) ?? 0
        
        // innit Model
        tipCalc = TipCalculator(bill: bill, tip: defaultTip, split: defaultSplit)
        
        // update default value
        UIView.animate(withDuration: 0.8, animations: {
            self.tipSlider.setValue(defaultTip, animated: true)
            self.splitSlider.setValue(Float(defaultSplit), animated: true)
        })
        
        billField.becomeFirstResponder()
        
        // calculator
        calcTip()
        
        // update UI
        updateUI()
    }
    
    func getCurrencySymbol() -> String {
        let locale = NSLocale.current
        return locale.currencySymbol! as String
    }
    
    func calcTip(){
        tipCalc.tip = Float(tipSlider.value)
        tipCalc.bill = Float(billField.text!) ?? 0
        tipCalc.split = Int(splitSlider.value)
        tipCalc.calculator()
        updateUI()
    }
    
    func updateUI(){
        
        resultLabel.text = "Total: " + fm.string(from: NSNumber(value: tipCalc.totalAmount))!
        
        tipResultLabel.text = "Tip: " + fm.string(from: NSNumber(value: tipCalc.tipAmount))!
        
        splitResultLabel.text = "Result: " + fm.string(from: NSNumber(value: tipCalc.resultSplit))!
        
        tipLabel.text! = String(format: "Tip %d%%:", arguments: [Int(tipSlider.value * 100)])
        
        splitLabel.text! = String(format: "Split: %d", arguments: [Int(splitSlider.value)])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    // MARK: - UIControl Events
    
    @IBAction func sliderOrFieldOnChange(_ sender: AnyObject) {
        calcTip()
    }
    
    @IBAction func billFieldOnChange(_ sender: AnyObject) {
        let defaultBill = UserDefaults.standard
        let bill = Float(billField.text!) ?? 0
        let currentTime = NSDate().timeIntervalSince1970
        defaultBill.set(bill, forKey: "billValue")
        defaultBill.set(currentTime, forKey: "billTime")
    }

}
