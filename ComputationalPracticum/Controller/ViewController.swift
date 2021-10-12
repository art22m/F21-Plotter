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
//        print(sender.is)
    }
    
    @IBAction func plotTapped(_ sender: NSButton) {
        let x_0: Double = xZeroTextField.doubleValue
        let y_0: Double = yZeroTextField.doubleValue
        let N: Int = NTextField.integerValue
        let X: Double = XTextField.doubleValue
        
        // handle errors!!
        
        let equation = TestDiffEq(x_0: x_0, y_0: y_0)
        let plotter = PlotterModel(equation: equation, N: N, X: X)
        
        let data = LineChartData()
        
        if eulerCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsEuler(), label: "Euler")
            ds.drawCirclesEnabled = false
            ds.colors = [NSUIColor.red]
            
            data.addDataSet(ds)
        }
        
        if improvedEulerCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsImprovedEuler(), label: "Improved Euler")
            ds.drawCirclesEnabled = false
            ds.colors = [NSUIColor.green]
            
            data.addDataSet(ds)
        }
        
        if rungeKuttaCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsRungeKutta(), label: "Runge-Kutta")
            ds.drawCirclesEnabled = false
            ds.colors = [NSUIColor.blue]
            
            data.addDataSet(ds)
        }
    
                        
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
