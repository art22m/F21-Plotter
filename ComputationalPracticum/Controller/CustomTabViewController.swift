//
//  CustomTabBarViewController.swift
//  ComputationalPracticum
//
//  Created by Артём Мурашко on 16.10.2021.
//

import Foundation
import AppKit

class CustomTabViewController: NSTabViewController {
    override func viewWillAppear() {
        super.viewWillAppear()
        self.tabView.window?.backgroundColor = NSColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    }
}
