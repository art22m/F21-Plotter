//
//  GlobalErrorViewController.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 17.10.2021.
//

import Cocoa
import Foundation
import Charts

class GlobalErrorViewController: NSViewController {
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var errorsLineChartView: LineChartView!
    @IBOutlet var backgroundView: NSView!
    @IBOutlet weak var eulerCheckBox: NSButton!
    @IBOutlet weak var improvedEulerCheckBox: NSButton!
    @IBOutlet weak var rungeKuttaCheckBox: NSButton!
    @IBOutlet weak var plotButton: NSButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Program Window
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
        // Background View
        backgroundView.wantsLayer = true
        backgroundView.layer?.borderWidth = 2
        backgroundView.layer?.borderColor = NSColor.lightGray.cgColor

        backgroundView.layer?.backgroundColor = NSColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
        scrollView.backgroundColor = NSColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
    }
    
}
