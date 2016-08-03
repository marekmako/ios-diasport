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
    
    @IBOutlet weak var weightSegmentControl: UISegmentedControl!
    @IBOutlet weak var glycemiaUnitSegmentControl: UISegmentedControl!
    
    // MARK: Initial color for segmentcontroll
    private func initialColorForSegmentControl(segmentControl: UISegmentedControl) {
        let selectedIndex = segmentControl.selectedSegmentIndex
        
        for i in 0..<segmentControl.subviews.count {
            if selectedIndex == i {
                view.tintColor = UIColor(red: 92/255, green: 182/255, blue: 214/255, alpha: 1)
            }
        }
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        initialColorForSegmentControl(weightSegmentControl)
    }
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
