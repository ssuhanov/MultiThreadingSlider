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

    func moveSliderRight() {
        self.currentValue += 0.01
        print("+++ \(self.currentValue)")
        
        dispatch_async(dispatch_get_main_queue(), {
            self.outletSlider.value = self.currentValue
            self.outletLabel.text = String(format: "%.2f", self.currentValue)
        })
        
    }
    
    func moveSliderLeft() {
        self.currentValue -= 0.01
        print("--- \(self.currentValue)")
        
        dispatch_async(dispatch_get_main_queue(), {
            self.outletSlider.value = self.currentValue
            self.outletLabel.text = String(format: "%.2f", self.currentValue)
        })
    }
    
    func startQueue(queueName: String, moveFunction: () -> ()) {
        dispatch_async(dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT)) {
            while self.currentValue > 0.01 && self.currentValue < 99.99 {
                moveFunction()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startQueue("queueForIncrement1", moveFunction: moveSliderRight)
        startQueue("queueForDecrement1", moveFunction: moveSliderLeft)
        startQueue("queueForDecrement2", moveFunction: moveSliderLeft)
        startQueue("queueForIncrement2", moveFunction: moveSliderRight)
    }

}

