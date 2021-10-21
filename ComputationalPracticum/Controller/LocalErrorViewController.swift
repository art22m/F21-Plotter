//
//  ViewController.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 11.10.2021.
//

import Cocoa
import Foundation
import Charts

class LocalErrorViewController: NSViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet var errorsLineChartView: LineChartView!
    @IBOutlet var backgroundView: NSView!
    @IBOutlet var graphsLineChartView: LineChartView!
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
    let plotter: PlotterModel = PlotterModel(equation: DifferentialEquationVar1(x_0: 0, y_0: 0))
    
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
        
        // Errors ChartView
        errorsLineChartView.gridBackgroundColor = NSUIColor.white
        errorsLineChartView.drawBordersEnabled = true
        errorsLineChartView.xAxis.labelPosition = .bottom
        errorsLineChartView.rightAxis.drawAxisLineEnabled = false
        errorsLineChartView.rightAxis.drawLabelsEnabled = false
        errorsLineChartView.noDataText = ""
        errorsLineChartView.borderLineWidth = 2
        errorsLineChartView.borderColor = NSColor.lightGray


        // Graph ChartView
        graphsLineChartView.gridBackgroundColor = NSUIColor.white
        graphsLineChartView.drawBordersEnabled = true
        graphsLineChartView.xAxis.labelPosition = .bottom
        graphsLineChartView.rightAxis.drawAxisLineEnabled = false
        graphsLineChartView.rightAxis.drawLabelsEnabled = false
        graphsLineChartView.borderLineWidth = 2
        graphsLineChartView.borderColor = NSColor.lightGray

        animateNoDataText()
        
        // Error alert
        alert.alertStyle = NSAlert.Style.warning
        alert.messageText = "Input data error"
        alert.addButton(withTitle: "Okay")
    }
    
    // MARK: - IBAction
        
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
            alert.runModal()
        } catch {
            alert.informativeText = "Something strange occur"
            alert.runModal()
        }
    }
    
    // MARK: - LineCharts drawing
    
    func drawLineChart() {
        let pointsData = LineChartData()
        let errorsData = LineChartData()
        
        if eulerCheckBox.state == .on {
            let dsPoints = LineChartDataSet(entries: plotter.getPointsEuler(), label: "Euler")
            dsPoints.drawCirclesEnabled = false
            dsPoints.drawValuesEnabled = false
            dsPoints.lineWidth = 2
            dsPoints.colors = [NSUIColor.red]
            pointsData.addDataSet(dsPoints)
            
            let dsErrors = LineChartDataSet(entries: plotter.getLocalErrorsEuler(), label: "Euler")
            dsErrors.drawCirclesEnabled = false
            dsErrors.drawValuesEnabled = false
            dsErrors.lineWidth = 2
            dsErrors.colors = [NSUIColor.red]
            errorsData.addDataSet(dsErrors)
        }
        
        if improvedEulerCheckBox.state == .on {
            let dsPoints = LineChartDataSet(entries: plotter.getPointsImprovedEuler(), label: "Improved Euler")
            dsPoints.drawCirclesEnabled = false
            dsPoints.drawValuesEnabled = false
            dsPoints.lineWidth = 2
            dsPoints.colors = [NSUIColor.blue]
            pointsData.addDataSet(dsPoints)
            
            let dsErrors = LineChartDataSet(entries: plotter.getLocalErrorsImproverEuler(), label: "Improved Euler")
            dsErrors.drawCirclesEnabled = false
            dsErrors.drawValuesEnabled = false
            dsErrors.lineWidth = 2
            dsErrors.colors = [NSUIColor.blue]
            errorsData.addDataSet(dsErrors)
        }
        
        if rungeKuttaCheckBox.state == .on {
            let dsPoints = LineChartDataSet(entries: plotter.getPointsRungeKutta(), label: "Runge-Kutta")
            dsPoints.drawCirclesEnabled = false
            dsPoints.drawValuesEnabled = false
            dsPoints.lineWidth = 2
            dsPoints.colors = [NSUIColor.green]
            pointsData.addDataSet(dsPoints)
            
            let dsErrors = LineChartDataSet(entries: plotter.getLocalErrorsRungeKutta(), label: "Runge-Kutta")
            dsErrors.drawCirclesEnabled = false
            dsErrors.drawValuesEnabled = false
            dsErrors.lineWidth = 2
            dsErrors.colors = [NSUIColor.green]
            errorsData.addDataSet(dsErrors)
        }
        
        if analyticalCheckBox.state == .on {
            let ds = LineChartDataSet(entries: plotter.getPointsExact(), label: "Exact")
            ds.drawCirclesEnabled = false
            ds.drawValuesEnabled = false
            ds.lineWidth = 2
            ds.colors = [NSUIColor.black]
            
            pointsData.addDataSet(ds)
        }
        
        graphsLineChartView.data = pointsData
        errorsLineChartView.data = errorsData
                    
        // Say to Chart View that we set new data
        graphsLineChartView.notifyDataSetChanged()
        errorsLineChartView.notifyDataSetChanged()
    }    
}

// MARK: - Animations

extension LocalErrorViewController {
    func animateNoDataText() {
        let noDataText = "Please specify the parameters on the right side of the window."
        let timeInterval: Double = 1 / Double(noDataText.count)
        var charIndex = 0.0
        
        graphsLineChartView.noDataText = ""
        graphsLineChartView.notifyDataSetChanged()
        
        for letter in noDataText {
            Timer.scheduledTimer(withTimeInterval: timeInterval * charIndex, repeats: false) { (timer) in
                self.graphsLineChartView.noDataText.append(letter)
                self.graphsLineChartView.notifyDataSetChanged()
            }
            charIndex += 1
        }
    }
}
