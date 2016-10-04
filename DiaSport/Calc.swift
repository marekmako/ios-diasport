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
    
    // MARK: IBOutlet
    
    @IBOutlet weak var durationButton: UIButton! {
        didSet {
            durationButton.setTitle("", for: UIControlState())
        }
    }
    
    @IBOutlet weak var intensityButton: UIButton! {
        didSet {
            intensityButton.setTitle("", for: UIControlState())
        }
    }

    @IBOutlet weak var currentGlycemiaButton: UIButton! {
        didSet {
            currentGlycemiaButton.setTitle("", for: UIControlState())
        }
    }
    
    @IBOutlet weak var calcButton: UIButton! {
        didSet {
            calcButton.layer.cornerRadius = 5
        }
    }
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        dataContainer.delegate = self
        
        dataIncomplete()
    }
    
    // MARK: CalcPickerDataContainerDelegate
    
    func dataCompleted() {
        calcButton.isHidden = false
    }
    
    func dataIncomplete() {
        calcButton.isHidden = true
    }
    
    func durationValueChanged(_ value: String) {
        durationButton.setTitle(value, for: UIControlState())
    }
    
    func intensityValueChanged(_ value: String) {
        intensityButton.setTitle(value, for: UIControlState())
    }
    
    func currentGlycemiaValueChanged(_ value: String) {
        currentGlycemiaButton.setTitle(value, for: UIControlState())
    }
    
    // MARK: Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toCalcResultViewController" {
            guard (dataContainer.durationDataIndex != nil) else {
                dataIncomplete()
                return false
            }
            guard (dataContainer.intensityDataIndex != nil) else {
                dataIncomplete()
                return false
            }
            guard  (dataContainer.currentGlycemiaDataIndex != nil) else {
                dataIncomplete()
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let calcResultVC = segue.destination as? CalcResultViewController {
            calcResultVC.durationIndex = dataContainer.durationDataIndex
            calcResultVC.intentsityIndex = dataContainer.intensityDataIndex
            calcResultVC.currentGlycemiaIndex = dataContainer.currentGlycemiaDataIndex
        }
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        // MARK: picker text color
        return NSAttributedString(string: data[component][row], attributes: [NSForegroundColorAttributeName : UIColor.white])
    }
}



protocol CalcPickerDataContainerDelegate {
    func dataCompleted()
    func dataIncomplete()
    func durationValueChanged(_ value: String)
    func intensityValueChanged(_ value: String)
    func currentGlycemiaValueChanged(_ value: String)
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
    
    fileprivate func isComplete() {
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
    
    fileprivate let userSettings = UserSettings()
    
    /// 0 duration, 1 intensity, 2 massunit, 3 glycemia
    fileprivate var data: [[[[String]]]]!
    
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
    
    func get(durationIndex: Int, intensityIndex: Int, currentGlycemiaIndex: Int) -> String {
        let weightUnitIndex: Int = (userSettings.weightUnit == .gram ? 1 : 0)
        return data[durationIndex][intensityIndex][weightUnitIndex][currentGlycemiaIndex]
    }
}



class CalcResultViewController: UIViewController {
    
    let calcResult = CalcResult()
    let userWightUnit = UserSettings().weightUnit
    
    var durationIndex: Int?
    var intentsityIndex: Int?
    var currentGlycemiaIndex: Int?
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var resultView: UIView! {
        didSet {
            resultView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var resultValueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.layer.borderWidth = 1
            cancelButton.layer.borderColor = UIColor.white.cgColor
            cancelButton.layer.cornerRadius = 5
        }
    }
    
    
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: lifecycle
    
    override func viewDidLoad() {
        // TODO: ak som neprisiel zo segue hodnoty nebudu nastavene, fatal error
        guard durationIndex != nil else {
            fatalError("bol VC volany zo segue, kde som nastavil durationIndex?")
        }
        guard intentsityIndex != nil else {
            fatalError("bol VC volany zo segue, kde som nastavil intentsityIndex?")
        }
        guard currentGlycemiaIndex != nil else {
            fatalError("bol VC volany zo segue, kde som nastavil currentGlycemiaIndex?")
        }
        
        resultValueLabel.text = calcResult.get(durationIndex: durationIndex!, intensityIndex: intentsityIndex!, currentGlycemiaIndex: currentGlycemiaIndex!)
        unitLabel.text = userWightUnit.describe()
    }
}
