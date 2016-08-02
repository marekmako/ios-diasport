//
//  Intensity.swift
//  DiaSport
//
//  Created by Marek Mako on 01/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class IntensityViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var intensityPicker: IntensityPickerView!
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        if let calcCtrl = presentingViewController as? CalcViewController {
            calcCtrl.dataContainer.intensityValue = intensityPicker.selectedValueAsString()
            calcCtrl.dataContainer.intensityDataIndex = intensityPicker.selectedValueAsCalcResutIndex()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 20/255, green: 65/255, blue: 110/255, alpha: 0.9)
    }
}


class IntensityPickerView: CalcPickerView, CalcPickerViewSelectedDataProtocol {
    
    override var data: [[String]] {
        return [["Low", "Medium", "High"]]
    }
    
    // MARK: CalcPickerViewSelectedDataProtocol
    
    func selectedValueAsString() -> String {
        return data[0][selectedRowInComponent(0)]
    }
    
    func selectedValueAsCalcResutIndex() -> Int {
        return selectedRowInComponent(0)
    }
}