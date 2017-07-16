//
//  ViewController.swift
//  Junk
//
//  Created by Bridget Bailey on 2/7/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let author = Author()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func myAction(_ sender: UIButton) {
        author.printName()
        //print(author.firstName + " " + author.lastName)
    }

}

