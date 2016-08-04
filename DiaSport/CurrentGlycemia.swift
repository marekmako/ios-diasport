//
//  CurrentGlycemia.swift
//  DiaSport
//
//  Created by Marek Mako on 01/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class CurrentGlycemiaControllerView: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var currentGlycemiaPicker: CurrentGlycemiaPickerView!
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        if let calcCtrl = presentingViewController as? CalcViewController {
            calcCtrl.dataContainer.currentGlycemiaValue = currentGlycemiaPicker.selectedValueAsString()
            calcCtrl.dataContainer.currentGlycemiaDataIndex = currentGlycemiaPicker.selectedValueAsCalcResutIndex()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: lifecycle
}


class CurrentGlycemiaPickerView: CalcPickerView, CalcPickerViewSelectedDataProtocol {
    
    let settings = UserSettings()
    
    private var mmollSelectedValue: [String] = ["0", ".", "0"]
    
    private lazy var mmollData: [[String]] = {
        var integers = [String]() // cele cisla
        for i in 3..<16 {
            integers.append("\(i)")
        }
        
        let separator = ["."]
        
        var decimals = [String]() // desatinne cisla
        for i in 0..<10 {
            decimals.append("\(i)")
        }
        
        return [integers, separator, decimals, ["mmol/l"]]
    }()
    
    private lazy var mgdlData: [[String]] = {
        var integers = [String]()
        
        for var i in 54..<271 {
            integers.append("\(i)")
            
            i += 2
        }
        return [integers, ["mg/dl"]]
    }()
    
    override var data: [[String]] {
        switch settings.glycemiaUnit {
        case .Mgdl:
            
            return mgdlData

        case .Mmoll:
            return mmollData
        }
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch settings.glycemiaUnit {
        case .Mmoll: // 4 prvky
            let partialWidth: CGFloat = pickerView.bounds.width / 4
            
            switch component {
            case 0:
                return partialWidth
            case 1:
                return partialWidth / 4
            case 2:
                return partialWidth
            case 3:
                return partialWidth
            default:
                return 0.0
            }
            
        case .Mgdl: // 2 prvky
            return pickerView.bounds.width / 2
        }
    }
    
    // MARK: CalcPickerViewSelectedDataProtocol
    
    func selectedValueAsString() -> String {
        switch settings.glycemiaUnit {
        case .Mmoll:
            return "\(data[0][selectedRowInComponent(0)])" +
                "\(data[1][selectedRowInComponent(1)])" +
                "\(data[2][selectedRowInComponent(2)])"
            
        case .Mgdl:
            return data[0][selectedRowInComponent(0)]
        }
    }
    
    func selectedValueAsCalcResutIndex() -> Int {
        return PickerValueToCalcResultIndexTransformator.transform(selectedValueAsString(), unit: settings.glycemiaUnit)!
    }
    
    
    
    private class PickerValueToCalcResultIndexTransformator {
        
        class func transform(value: String, unit: GlycemiaUnit) -> Int? {
            let doubleValue = (value as NSString).doubleValue
            
            switch unit {
            case .Mgdl:
                return mgdlToIndex(doubleValue)
            case .Mmoll:
                return mmollToIndex(doubleValue)
            }
        }
        
        class func mmollToIndex(value: Double) -> Int? {
            let indexRanges =  [ [3.0, 5.5], [5.6, 8.0], [8.1, 11.0], [11.1, 16.0] ]
            
            for i in 0..<indexRanges.count {
                let leftValue = indexRanges[i][0]
                let rightValue = indexRanges[i][1]
                
                if leftValue <= value && rightValue >= value {
                    return i
                }
            }
            
            return nil
        }
        
        class func mgdlToIndex(value: Double) -> Int? {
            let indexRanges =  [ [54.0, 99.0], [100.0, 144.0], [145.0, 198.0], [198.0, 271.0] ]
            
            for i in 0..<indexRanges.count {
                let leftValue = indexRanges[i][0]
                let rightValue = indexRanges[i][1]
                
                if leftValue <= value && rightValue >= value {
                    return i
                }
            }
            
            return nil
        }
    }
}