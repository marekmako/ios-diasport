//
//  Settings.swift
//  DiaSport
//
//  Created by Marek Mako on 28/07/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: IBOutlet
    
    @IBOutlet weak var weightSegmentControl: UISegmentedControl! {
        didSet {
            styleForSegmentControl(weightSegmentControl)
        }
    }
    @IBOutlet weak var glycemiaUnitSegmentControl: UISegmentedControl! {
        didSet {
            styleForSegmentControl(glycemiaUnitSegmentControl)
        }
    }
    
    // MARK: Initial style for segmentcontroll
    private func styleForSegmentControl(segmentControl: UISegmentedControl) {
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)
        segmentControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Selected)
    }
    
    // MARK: lifecycle
}



enum WeightUnit {
    case Gram, Ounce
}



enum GlycemiaUnit {
    case Mmoll, Mgdl
}



// TODO: implement
class UserSettings {
    
    var weightUnit: WeightUnit {
        get {
            return WeightUnit.Gram
        }
        set {
            
        }
    }
    
    var glycemiaUnit: GlycemiaUnit {
        get {
            return GlycemiaUnit.Mmoll
        }
        set {
            
        }
    }
}
