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
    @IBOutlet var lineChartView: LineChartView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
    }
    
    override open func viewWillAppear() {
    }
}
