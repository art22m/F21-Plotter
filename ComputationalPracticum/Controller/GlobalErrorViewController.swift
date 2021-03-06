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
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    @IBOutlet var errorsLineChartView: LineChartView!
    
    @IBOutlet weak var NiTextField: NSTextField!
    @IBOutlet weak var NfTextField: NSTextField!
    
    @IBOutlet weak var eulerCheckBox: NSButton!
    @IBOutlet weak var improvedEulerCheckBox: NSButton!
    @IBOutlet weak var rungeKuttaCheckBox: NSButton!
    @IBOutlet weak var plotButton: NSButton!
    @IBOutlet weak var backButton: NSButton!
    
    let alert: NSAlert = NSAlert()
    var plotter: PlotterModel? = nil
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Program Window
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height);
        
        // Errors ChartView
        errorsLineChartView.gridBackgroundColor = NSUIColor.white
        errorsLineChartView.drawBordersEnabled = true
        errorsLineChartView.xAxis.labelPosition = .bottom
        errorsLineChartView.rightAxis.drawAxisLineEnabled = false
        errorsLineChartView.rightAxis.drawLabelsEnabled = false
        errorsLineChartView.noDataText = ""
        errorsLineChartView.borderLineWidth = 2
        errorsLineChartView.borderColor = NSColor.lightGray
        animateNoDataText()
        
        progressIndicator.isHidden = true
        
        // Background View
        scrollView.backgroundColor = NSColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    }
    
    // MARK: - @IBAction
    @IBAction func plotTapped(_ sender: NSButton) {
        // Get entered data from text fields
        let Ni: String = NiTextField.stringValue
        let Nf: String = NfTextField.stringValue
        
        // If there are no errors, set new parameters from textFields to
        // the plotter model and plot the graphs.
        
        do {
            try plotter?.checkInputBorders(N_i: Ni, N_f: Nf)
            drawLineChart(Ni: Int(Ni)!, Nf: Int(Nf)!)
        } catch InputDataError.invalid_borders_inverval {
            alert.informativeText = InputDataError.invalid_borders_inverval.description
            alert.runModal()
        } catch InputDataError.invalid_border {
            alert.informativeText = InputDataError.invalid_border.description
            alert.runModal()
        } catch {
            alert.informativeText = "Something strange occur"
            alert.runModal()
        }
    }
     
    @IBAction func backTapped(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    // MARK: - LineCharts drawing
    
    func drawLineChart(Ni: Int, Nf: Int) {
        let errorsData = LineChartData()
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(self)
        
        if eulerCheckBox.state == .on {
            plotter?.computeGlobalErrorsPoints(using: .EULER, N_i: Ni, N_f: Nf, completion: { points in
                let dsErrors = LineChartDataSet(entries: points, label: "Euler")
                dsErrors.drawCirclesEnabled = false
                dsErrors.drawValuesEnabled = false
                dsErrors.lineWidth = 2
                dsErrors.colors = [NSUIColor.red]
                errorsData.addDataSet(dsErrors)
                
                DispatchQueue.main.async {
                    self.errorsLineChartView.data = errorsData
                    self.errorsLineChartView.notifyDataSetChanged()
                    self.progressIndicator.stopAnimation(self)
                    self.progressIndicator.isHidden = true
                }
            })
        }
        
        if improvedEulerCheckBox.state == .on {
            plotter?.computeGlobalErrorsPoints(using: .IMPROVED_EULER, N_i: Ni, N_f: Nf, completion: { points in
                let dsErrors = LineChartDataSet(entries: points, label: "Improved Euler")
                dsErrors.drawCirclesEnabled = false
                dsErrors.drawValuesEnabled = false
                dsErrors.lineWidth = 2
                dsErrors.colors = [NSUIColor.blue]
                errorsData.addDataSet(dsErrors)
                
                DispatchQueue.main.async {
                    self.errorsLineChartView.data = errorsData
                    self.errorsLineChartView.notifyDataSetChanged()
                    self.progressIndicator.stopAnimation(self)
                    self.progressIndicator.isHidden = true
                }
            })
        }
        
        if rungeKuttaCheckBox.state == .on {
            plotter?.computeGlobalErrorsPoints(using: .RUNGE_KUTTA, N_i: Ni, N_f: Nf, completion: { points in
                let dsErrors = LineChartDataSet(entries: points, label: "Runge-Kutta")
                dsErrors.drawCirclesEnabled = false
                dsErrors.drawValuesEnabled = false
                dsErrors.lineWidth = 2
                dsErrors.colors = [NSUIColor.green]
                errorsData.addDataSet(dsErrors)
                
                DispatchQueue.main.async {
                    self.errorsLineChartView.data = errorsData
                    self.errorsLineChartView.notifyDataSetChanged()
                    self.progressIndicator.stopAnimation(self)
                    self.progressIndicator.isHidden = true
                }
            })
        }
    }
}

// MARK: - Animations
extension GlobalErrorViewController {
    func animateNoDataText() {
        let noDataText = "Please specify left and right border"
        let timeInterval: Double = 1 / Double(noDataText.count)
        var charIndex = 0.0
        
        errorsLineChartView.noDataText = ""
        errorsLineChartView.notifyDataSetChanged()
        
        for letter in noDataText {
            Timer.scheduledTimer(withTimeInterval: timeInterval * charIndex, repeats: false) { (timer) in
                self.errorsLineChartView.noDataText.append(letter)
                self.errorsLineChartView.notifyDataSetChanged()
            }
            charIndex += 1
        }
    }
}
