//
//  Calc.swift
//  DiaSport
//
//  Created by Marek Mako on 28/07/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit



class CalcViewController: UIViewController, CalcPickerDataContainerDelegate {
    
    let dataContainer = CalcPickerDataContainer()
    private lazy var calcResult = CalcResult()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var durationButton: UIButton! {
        didSet {
            durationButton.setTitle("", forState: .Normal)
        }
    }
    
    @IBOutlet weak var intensityButton: UIButton! {
        didSet {
            intensityButton.setTitle("", forState: .Normal)
        }
    }

    @IBOutlet weak var currentGlycemiaButton: UIButton! {
        didSet {
            currentGlycemiaButton.setTitle("", forState: .Normal)
        }
    }
    
    @IBOutlet weak var calcButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCalculate() {
        guard let durationDataIndex = dataContainer.durationDataIndex else {
            dataIncomplete()
            return
        }
        guard let intensityDataIndex = dataContainer.intensityDataIndex else {
            dataIncomplete()
            return
        }
        guard let currentGlycemiaDataIndex = dataContainer.currentGlycemiaDataIndex else {
            dataIncomplete()
            return
        }
        
        let result = calcResult.get(durationIndex: durationDataIndex, intensityIndex: intensityDataIndex, currentGlycemiaIndex: currentGlycemiaDataIndex)
        
        let alertCtrl = UIAlertController(title: "test", message: result, preferredStyle: .ActionSheet)
        alertCtrl.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(alertCtrl, animated: true, completion: nil)
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        dataContainer.delegate = self
        
        dataIncomplete()
    }
    
    // MARK: CalcPickerDataContainerDelegate
    
    func dataCompleted() {
        calcButton.hidden = false
    }
    
    func dataIncomplete() {
        calcButton.hidden = true
    }
    
    func durationValueChanged(value: String) {
        durationButton.setTitle(value, forState: .Normal)
    }
    
    func intensityValueChanged(value: String) {
        intensityButton.setTitle(value, forState: .Normal)
    }
    
    func currentGlycemiaValueChanged(value: String) {
        currentGlycemiaButton.setTitle(value, forState: .Normal)
    }
}



protocol CalcPickerViewSelectedDataProtocol {
    func selectedValueAsString() -> String
    func selectedValueAsCalcResutIndex() -> Int
}



/// base class for all picker in calc controller
class CalcPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// override pre naplnenie datami
    var data: [[String]] {
        return [[String]]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
    }
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // MARK: picker text color
        return NSAttributedString(string: data[component][row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
    }
}



protocol CalcPickerDataContainerDelegate {
    func dataCompleted()
    func dataIncomplete()
    func durationValueChanged(value: String)
    func intensityValueChanged(value: String)
    func currentGlycemiaValueChanged(value: String)
}



/// data indexy sluzia sucastne ako calc result indexy
class CalcPickerDataContainer {
    
    var delegate: CalcPickerDataContainerDelegate?
    
    var durationValue: String? {
        didSet {
            guard let _ = durationValue else {
                return
            }
            delegate?.durationValueChanged(durationValue!)
            isComplete()
        }
    }
    var durationDataIndex: Int? {
        didSet {
            isComplete()
        }
    }
    
    var intensityValue: String? {
        didSet {
            guard let _ = intensityValue else {
                return
            }
            delegate?.intensityValueChanged(intensityValue!)
            isComplete()
        }
    }
    
    var intensityDataIndex: Int? {
        didSet {
            isComplete()
        }
    }
    
    var currentGlycemiaValue: String? {
        didSet {
            guard let _ = currentGlycemiaValue else {
                return
            }
            delegate?.currentGlycemiaValueChanged(currentGlycemiaValue!)
            isComplete()
        }
    }
    
    var currentGlycemiaDataIndex: Int? {
        didSet {
            isComplete()
        }
    }
    
    // MARK: support for CalcPickerDataContainerDelegate
    
    private func isComplete() {
        guard let _ = durationDataIndex else {
            delegate?.dataIncomplete()
            return
        }
        guard let _ = intensityDataIndex else {
            delegate?.dataIncomplete()
            return
        }
        guard let _ = currentGlycemiaDataIndex else {
            delegate?.dataIncomplete()
            return
        }
        
        delegate?.dataCompleted()
    }
}



class CalcResult {
    
    private let userSettings = UserSettings()
    
    /// 0 duration, 1 intensity, 2 massunit, 3 glycemia
    private var data: [[[[String]]]]!
    
    init() {
        data = [
            [
                [
                    ["0 - 0.18", "0", "0", "0"], // oz
                    ["0 - 5", "0", "0", "0"], // g
                ],
                [
                    ["0.18 - 0.35", "0 - 0.35", "0 - 0.18", "0"],
                    ["5 - 10", "0 - 10", "0 - 5", "0"]
                ],
                [
                    ["0 - 0.53", "0 - 0.53", "0 - 0.35", "0 - 0.18"],
                    ["0 - 15", "0 - 15", "0 - 10", "0 - 5"] // skontrolovat hodnoty podla knihy
                ],
            ],
            [
                [
                    ["0.18 - 0.35", "0 - 0.35", "0", "0"],
                    ["5 - 10", "0 - 10", "0", "0"]
                ],
                [
                    ["0.35 - 0.88", "0.35 - 0.71", "0.18 - 0.53", "0 - 0.35"],
                    ["10 - 25", "10 - 20", "5 - 15", "0 - 10"]
                ],
                [
                    ["0.53 - 1.23", "0.53 - 1.06", "0.35 - 0.88", "0.18 - 0.71"],
                    ["15 - 35", "15 - 30", "10 - 25", "5 - 20"]
                ],
            ],
            [
                [
                    ["0.18 - 0.53", "0.18 - 0.35", "0 - 0.18", "0"],
                    ["5 - 15", "5 - 10", "0 - 5", "0"],
                ],
                [
                    ["0.53 - 1.23", "0.35 - 1.06", "0.18 - 0.71", "0 - 0.35"],
                    ["15 - 35", "10 - 30", "5 - 20", "0 - 10"],
                ],
                [
                    ["0.71 - 1.41", "0.71 - 1.23", "0.53 - 1.06", "0.35 - 0.88"],
                    ["20 - 40", "20 - 35", "15 - 30", "10 - 25"],
                ],
            ],
            [
                [
                    ["0.35 - 0.53", "0.35 - 0.53", "0.18 - 0.35", "0 - 0.35"],
                    ["10 - 15", "10 - 15", "5 - 10", "0 - 5"]  // skontrolovat hodnoty podla knihy
                ],
                [
                    ["0.71 - 1.76", "0.53 - 1.41", "0.35 - 1.06", "0.18 - 0.53"],
                    ["20 - 50", "15 - 40", "10 - 30", "5 - 15"]
                ],
                [
                    ["1.06 - 1.59", "0.88 - 1.41", "0.88 - 1.23", "0.53 - 1.06"],
                    ["30 - 45", "25 - 40", "20 - 35", "15 - 30"]
                ],
            ],
            [
                [
                    ["0.53 - 0.71", "0.35 - 0.71", "0.18 - 0.35", "0 - 0.35"],
                    ["15 - 20", "10 - 20", "5 - 15", "0 - 10"]
                ],
                [
                    ["1.06 - 2.12", "0.88 - 1.76", "0.71 - 1.23", "0.35 - 0.71"],
                    ["30 - 60", "25 - 50", "20 - 35", "10 - 20"]
                ],
                [
                    ["1.59 - 2.47", "1.41 - 2.12", "1.06 - 1.76", "0.88 - 1.41"],
                    ["45 - 70", "40 - 60", "30 - 50", "25 - 40"]
                ],
            ],
            [
                [
                    ["0.53 - 1.06", "0.53 - 0.88", "0.35 - 0.71", "0.18 - 0.53"],
                    ["15 - 30", "15 - 25", "10 - 20", "5 - 15"]
                ],
                [
                    ["1.41 - 2.82", "1.23 - 2.47", "1.06 - 1.76", "0.53 - 1.06"],
                    ["40 - 80", "35 - 70", "30 - 50", "15 - 30"]
                ],
                [
                    ["2.12 - 3.17", "1.76 - 2.82", "1.41 - 2.47", "1.06 - 2.12"],
                    ["60 - 90", "50 - 80", "40 - 70", "30 - 60"]
                ],
            ],
            [
                [
                    ["1.06 - 1.59", "0.88 - 1.41", "0.71 - 1.06", "0.35 - 0.71"],
                    ["30 - 45", "25 - 40", "20 - 30", "10 - 20"]
                ],
                [
                    ["2.12 - 4.23", "1.76 - 3.53", "1.41 - 2.82", "0.88 - 1.41"],
                    ["60 - 120", "50 - 100", "40 - 80", "25 - 40"]
                ],
                [
                    ["3.17 - 4.76", "2.65 - 4.23", "2.12 - 3.70", "1.59 - 3.17"],
                    ["90 - 135", "75 - 120", "60 - 105", "45 - 90"]
                ],
            ]
        ]
    }
    
    func get(durationIndex durationIndex: Int, intensityIndex: Int, currentGlycemiaIndex: Int) -> String {
        let weightUnitIndex: Int = (userSettings.weightUnit == .Gram ? 1 : 0)
        return data[durationIndex][intensityIndex][weightUnitIndex][currentGlycemiaIndex]
    }
}