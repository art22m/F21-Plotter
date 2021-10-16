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
        
    let alert: NSAlert = NSAlert()
    let plotter: PlotterModel = PlotterModel(equation: TestDiffEq(x_0: 0, y_0: 0))
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Program Window
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
        // ChartView
        lineChartView.chartDescription?.text = "Graphs"
        lineChartView.gridBackgroundColor = NSUIColor.white
        lineChartView.drawBordersEnabled = true
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false

        
        lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        animateNoDataText()
        
        // Error alert
        alert.alertStyle = NSAlert.Style.warning
        alert.messageText = "Input data error"
        alert.addButton(withTitle: "Okay")
    }
        
    @IBAction func plotTapped(_ sender: NSButton) {
        // Get entered data from text fields
        let x_0: String = xZeroTextField.stringValue
        let y_0: String = yZeroTextField.stringValue
        let N: String   = NTextField.stringValue
        let X: String   = XTextField.stringValue
        
        // If there are no errors, set new parameters from textFields to
        // the plotter model and plot the graphs.
        do {
            try plotter.setNewParameters(x_0: x_0, y_0: y_0, N: N, X: X)
            drawLineChart()
        } catch InputDataError.invalid_interval {
            alert.informativeText = InputDataError.invalid_interval.description
            alert.runModal()
        } catch InputDataError.points_of_discontinuity {
            alert.informativeText = InputDataError.points_of_discontinuity.description
            alert.runModal()
        } catch InputDataError.miss_data {
            alert.informativeText = InputDataError.miss_data.description
            alert.runModal()
        } catch InputDataError.invalid_N {
            alert.informativeText = InputDataError.invalid_N.description
            alert.runModal()
        } catch InputDataError.out_of_boudns {
            alert.informativeText = InputDataError.out_of_boudns.description
        } catch {
            alert.informativeText = "Something strange occur"
            alert.runModal()
        }
    }
    
    func drawLineChart() {
        let data = LineChartData()
        
        if eulerCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsEuler(), label: "Euler")
            ds.drawCirclesEnabled = false
            ds.drawValuesEnabled = false
            ds.lineWidth = 2
            ds.colors = [NSUIColor.red]
            
            data.addDataSet(ds)
        }
        
        if improvedEulerCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsImprovedEuler(), label: "Improved Euler")
            ds.drawCirclesEnabled = false
            ds.drawValuesEnabled = false
            ds.lineWidth = 2
            ds.colors = [NSUIColor.green]
            
            data.addDataSet(ds)
        }
        
        if rungeKuttaCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsRungeKutta(), label: "Runge-Kutta")
            ds.drawCirclesEnabled = false
            ds.drawValuesEnabled = false
            ds.lineWidth = 2
            ds.colors = [NSUIColor.blue]
            
            data.addDataSet(ds)
        }
        
        if analyticalCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsExact(), label: "Exact")
            ds.drawCirclesEnabled = false
            ds.drawValuesEnabled = false
            ds.lineWidth = 2
            ds.colors = [NSUIColor.black]
            
            data.addDataSet(ds)
        }
        
        lineChartView.data = data
        // Say to Chart View that we set new data
        lineChartView.notifyDataSetChanged()
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
