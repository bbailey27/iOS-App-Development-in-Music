//
//  MenuViewController.swift
//  Aural Exam Practice
//
//  Created by Bridget Bailey on 4/19/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    //segmented control for users to choose the length of a quiz (number of questions to be asked)
    @IBOutlet var numQuestionControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //allow the detail and quiz views to return to the main menu
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
    
    //pass information (category and quiz length chosen) to the quiz view to properly choose questions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "Info" {//prevent trying to assign to nonexistant variables on the info segue
            let destination = segue.destination as! QuizViewController
            destination.chosenCategory = segue.identifier!
            destination.numQuestionsSelected = numQuestionControl.titleForSegment(at: numQuestionControl.selectedSegmentIndex)!
        }
    }
    
}
