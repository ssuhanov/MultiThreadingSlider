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
    
    func startQueue(queueName: String, value: Float) {
        dispatch_async(dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT)) {
            while self.currentValue > 0.01 && self.currentValue < 99.99 {
                self.currentValue += value
                print((value>0 ? "+++" : "---") + " \(self.currentValue)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.outletSlider.value = self.currentValue
                    self.outletLabel.text = String(format: "%.2f", self.currentValue)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startQueue("queueForIncrement1", value: 0.01)
        startQueue("queueForDecrement1", value: -0.01)
        startQueue("queueForDecrement2", value: -0.01)
        startQueue("queueForIncrement2", value: 0.01)
    }

}

