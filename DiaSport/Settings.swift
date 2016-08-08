//
//  Settings.swift
//  DiaSport
//
//  Created by Marek Mako on 28/07/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    private lazy var userSettings = UserSettings()
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onWeightChange(sender: UISegmentedControl) {
        let weightUnit = WeightUnit(rawValue: sender.selectedSegmentIndex)!
        userSettings.weightUnit = weightUnit
    }
    
    @IBAction func onGlycemiaUnitChange(sender: UISegmentedControl) {
        let glycemiaUnit = GlycemiaUnit(rawValue: sender.selectedSegmentIndex)!
        userSettings.glycemiaUnit = glycemiaUnit
    }
    
    
    // MARK: IBOutlet
    
    @IBOutlet weak var weightSegmentControl: UISegmentedControl! {
        didSet {
            styleForSegmentControl(weightSegmentControl)
            weightSegmentControl.selectedSegmentIndex = userSettings.weightUnit.rawValue
        }
    }
    @IBOutlet weak var glycemiaUnitSegmentControl: UISegmentedControl! {
        didSet {
            styleForSegmentControl(glycemiaUnitSegmentControl)
            glycemiaUnitSegmentControl.selectedSegmentIndex = userSettings.glycemiaUnit.rawValue
        }
    }
    
    // MARK: Initial style for segmentcontroll
    private func styleForSegmentControl(segmentControl: UISegmentedControl) {
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Selected)
    }
    
    // MARK: lifecycle
}



enum WeightUnit: Int {
    case Gram, Ounce
}



enum GlycemiaUnit: Int {
    case Mmoll, Mgdl
}



// TODO: implement
class UserSettings {
    
    private let kWeightUnitNameForUserDefaults = "weight_unit"
    
    private let kGlycemiaUnitNameForUserDefaults = "glycemia_unit"
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    var weightUnit: WeightUnit {
        get {
            let userDefaultValue = userDefaults.integerForKey(kWeightUnitNameForUserDefaults)
            return WeightUnit(rawValue: userDefaultValue)!
        }
        set {
            let userDefaultValue = newValue.rawValue
            userDefaults.setInteger(userDefaultValue, forKey: kWeightUnitNameForUserDefaults)
            userDefaults.synchronize()
        }
    }
    
    var glycemiaUnit: GlycemiaUnit {
        get {
            let userDefaultValue = userDefaults.integerForKey(kGlycemiaUnitNameForUserDefaults)
            return GlycemiaUnit(rawValue: userDefaultValue)!
        }
        set {
            let userDefaultValue = newValue.rawValue
            userDefaults.setInteger(userDefaultValue, forKey: kGlycemiaUnitNameForUserDefaults)
            userDefaults.synchronize()
        }
    }
}
