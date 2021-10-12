//
//  ViewController.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 11.10.2021.
//

import Cocoa
import Foundation
import Charts

class ViewController: NSViewController {
    // MARK: - IBOutlet
    
    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet weak var xZeroTextField: NSTextField!
    @IBOutlet weak var yZeroTextField: NSTextField!
    @IBOutlet weak var XTextField: NSTextField!
    @IBOutlet weak var NTextField: NSTextField!
    @IBOutlet weak var analyticalCheckBox: NSButton!
    @IBOutlet weak var eulerCheckBox: NSButton!
    @IBOutlet weak var improvedEulerCheckBox: NSButton!
    @IBOutlet weak var rungeKuttaCheckBox: NSButton!
    
    @IBOutlet weak var plotButton: NSButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
    }
    
    override open func viewWillAppear() {
        
    }
    
    @IBAction func plotTypeChanged(_ sender: NSButton) {
        print("Changed")
    }
    
    @IBAction func plotTapped(_ sender: NSButton) {
        print("plot")
    }
}
