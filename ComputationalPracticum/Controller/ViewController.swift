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
        
        animateNoDataText()
    }
    
    override open func viewWillAppear() {
        
    }
    
    @IBAction func plotTypeChanged(_ sender: NSButton) {
        print("Changed")
    }
    
    @IBAction func plotTapped(_ sender: NSButton) {
        let equotion = TestDiffEq(x_0: 0, y_0: 1)
        let plotter = PlotterModel(equation: equotion, N: 101, X: 10)
                
        
        let ds1 = LineChartDataSet(entries: plotter.getPointsEuler(), label: "Euler")
        ds1.drawCirclesEnabled = false
        ds1.colors = [NSUIColor.red]

        let ds2 = LineChartDataSet(entries: plotter.getPointsImprovedEuler(), label: "Improved Euler")
        ds2.drawCirclesEnabled = false
        ds2.colors = [NSUIColor.blue]
        
        
        let data = LineChartData()
        data.addDataSet(ds1)
        data.addDataSet(ds2)
        // Вынести вычисления 
                
        self.lineChartView.data = data
        self.lineChartView.gridBackgroundColor = NSUIColor.white
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
}

// MARK: - Animations

extension ViewController {
    func animateNoDataText() {
        let noDataText = "Please specify the parameters on the right side of the window."
        let timeInterval: Double = 1 / Double(noDataText.count)
        var charIndex = 0.0
        
        lineChartView.noDataText = ""
        lineChartView.notifyDataSetChanged()
        
        for letter in noDataText {
            Timer.scheduledTimer(withTimeInterval: timeInterval * charIndex, repeats: false) { (timer) in
                self.lineChartView.noDataText.append(letter)
                self.lineChartView.notifyDataSetChanged()
            }
            charIndex += 1
        }
    }
}
