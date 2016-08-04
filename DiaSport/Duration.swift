//
//  Duration.swift
//  DiaSport
//
//  Created by Marek Mako on 01/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class DurationViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var durationPicker: DurationPickerView!
    
    // MARK: IBAction
    
    @IBAction func onCancel(sender: AnyObject) {
        if let calcCtrl = presentingViewController as? CalcViewController {
            calcCtrl.dataContainer.durationValue = durationPicker.selectedValueAsString()
            calcCtrl.dataContainer.durationDataIndex = durationPicker.selectedValueAsCalcResutIndex()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: lifecycle
}


class DurationPickerView: CalcPickerView, CalcPickerViewSelectedDataProtocol {
    
    override var data: [[String]] {
        return [["15", "30", "45", "60", "90", "120", "180"], ["min"]]
    }
    
    // MARK: CalcPickerViewSelectedDataProtocol
    
    func selectedValueAsString() -> String {
        return data[0][selectedRowInComponent(0)]
    }
    
    func selectedValueAsCalcResutIndex() -> Int {
        return selectedRowInComponent(0)
    }
}

