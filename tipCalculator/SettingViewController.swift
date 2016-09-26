//
//  SettingViewController.swift
//  tipCalculator
//
//  Created by Un on 9/25/16.
//  Copyright © 2016 Un. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK - IBOutlet
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var defaultSplitLabel: UILabel!
    @IBOutlet weak var defaultTipSlider: UISlider!
    @IBOutlet weak var defaultSplitSlider: UISlider!
    
    // MARK - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUISettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUISettings(){
        
        let defaultSettings = UserDefaults.standard
        let defaultTip = defaultSettings.float(forKey: "defaultTipSetting")
        let defaultSplit = defaultSettings.integer(forKey: "defaultSplitSetting")
        
        // update label
        defaultTipLabel.text = String(format: "Default Tip: %02d%%", Int(defaultTip * 100))
        defaultSplitLabel.text = String(format: "Default Split: %d", Int(defaultSplit))
        
        // update slider
        defaultTipSlider.setValue(defaultTip, animated: true)
        defaultSplitSlider.setValue(Float(defaultSplit), animated: true)
        
    }
    
    func updateSettings(defaultTip: Float, defaultSplit: Int){
        let defaultSettings = UserDefaults.standard
        defaultSettings.set(defaultTip, forKey: "defaultTipSetting")
        defaultSettings.set(defaultSplit, forKey: "defaultSplitSetting")
        defaultSettings.synchronize()
    }
    
    // MARK - UIControl Event
    
    @IBAction func defaultSliderOnChange(_ sender: AnyObject) {
        
        let defaultTip = Float(defaultTipSlider.value)
        let defaultSplit = Int(defaultSplitSlider.value)
        
        defaultTipLabel.text = String(format: "Default Tip: %02d%%", Int(defaultTip * 100))
        defaultSplitLabel.text = String(format: "Default Split: %d", Int(defaultSplit))
        
    }

    @IBAction func SettingOnSave(_ sender: AnyObject) {
        let defaultTip = Float(defaultTipSlider.value)
        let defaultSplit = Int(defaultSplitSlider.value)
        
        updateSettings(defaultTip: defaultTip, defaultSplit: defaultSplit)
    }
    
}
