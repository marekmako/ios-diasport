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
