//
//  Settings.swift
//  DiaSport
//
//  Created by Marek Mako on 28/07/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    fileprivate lazy var userSettings = UserSettings()
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onWeightChange(_ sender: UISegmentedControl) {
        let weightUnit = WeightUnit(rawValue: sender.selectedSegmentIndex)!
        userSettings.weightUnit = weightUnit
    }
    
    @IBAction func onGlycemiaUnitChange(_ sender: UISegmentedControl) {
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
    fileprivate func styleForSegmentControl(_ segmentControl: UISegmentedControl) {
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: UIControlState())
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.white], for: .selected)
    }
    
    // MARK: lifecycle
}



enum WeightUnit: Int {
    case gram, ounce
    
    func describe() -> String {
        switch self {
        case .gram:
            return "gram (g)"
        case .ounce:
            return "ounce (oz)"
        }
    }
}



enum GlycemiaUnit: Int {
    case mmoll, mgdl
    
    func describe() -> String {
        switch self {
        case .mgdl:
            return "mg/dl"
        case .mmoll:
            return "mmol/l"
        }
    }
}



// TODO: implement
class UserSettings {
    
    fileprivate let kWeightUnitNameForUserDefaults = "weight_unit"
    
    fileprivate let kGlycemiaUnitNameForUserDefaults = "glycemia_unit"
    
    fileprivate let userDefaults = UserDefaults.standard
    
    
    
    var weightUnit: WeightUnit {
        get {
            let userDefaultValue = userDefaults.integer(forKey: kWeightUnitNameForUserDefaults)
            return WeightUnit(rawValue: userDefaultValue)!
        }
        set {
            let userDefaultValue = newValue.rawValue
            userDefaults.set(userDefaultValue, forKey: kWeightUnitNameForUserDefaults)
            userDefaults.synchronize()
        }
    }
    
    var glycemiaUnit: GlycemiaUnit {
        get {
            let userDefaultValue = userDefaults.integer(forKey: kGlycemiaUnitNameForUserDefaults)
            return GlycemiaUnit(rawValue: userDefaultValue)!
        }
        set {
            let userDefaultValue = newValue.rawValue
            userDefaults.set(userDefaultValue, forKey: kGlycemiaUnitNameForUserDefaults)
            userDefaults.synchronize()
        }
    }
}
