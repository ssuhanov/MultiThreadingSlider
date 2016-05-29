//
//  ViewController.swift
//  MultiThreadingSlider
//
//  Created by Serge Sukhanov on 29.05.16.
//  Copyright © 2016 Serge Sukhanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var outletSlider: UISlider!
    @IBOutlet weak var outletLabel: UILabel!
    
    var currentValue: Float = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainQ = dispatch_get_main_queue()
        let queueForIncrement = dispatch_queue_create("queueForIncrement", DISPATCH_QUEUE_CONCURRENT)
        let queueForDecrement = dispatch_queue_create("queueForDecrement", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(queueForIncrement) {
            while self.currentValue > 0.01 && self.currentValue < 99.99 {
                self.currentValue += 0.01
                print(self.currentValue)
                
                dispatch_async(mainQ, {
                    self.outletSlider.value = self.currentValue
                    self.outletLabel.text = String(format: "%.2f", self.currentValue)
                })
            }
        }
        
        dispatch_async(queueForDecrement) {
            while self.currentValue > 0.01 && self.currentValue < 99.99 {
                self.currentValue -= 0.01
                print(self.currentValue)
                
                dispatch_async(mainQ, {
                    self.outletSlider.value = self.currentValue
                    self.outletLabel.text = String(format: "%.2f", self.currentValue)
                })
            }
        }
    }

}

