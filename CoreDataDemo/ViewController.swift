//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by MAC on 2019/3/19.
//  Copyright © 2019 zk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CoreDataManager.shared.rate(for: "cny", in: "okex")
        
        CoreDataManager.shared.save(for: "cny", value: 0.6745, exchange: "okex")
        
        
    }


}

