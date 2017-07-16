//
//  QuizViewController.swift
//  Aural Exam Practice
//
//  Created by Bridget Bailey on 4/11/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    
    
    @IBOutlet var qLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet var excerptSegmentedControl: UISegmentedControl!
    
    //Global variables for an instance of a quiz
    var questions = [Question]()//questin list for the chosen category/length
    var qNumber = Int()//index of chosen/current question
    var answerNumber = Int()//index of corrent answer - save answer after we remove the question from the list, provide shortcut access to it
    var currentQuestion: Question!//current question with all details
    var chosenCategory = String()//user-selected category for filtering questions
    var numQuestionsSelected = String()//user-selected number of questions for this quiz
    var numAsked = 0//count of questions asked so far
    var numQuestions = Int()//user-adjustable number of questions to ask in this quiz
    var numCorrect = Int()//number of questions answered correctly so far
    
    //set up the question list start the quiz
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the question list and filter by the chosen category
        createQuestionList()
        switch chosenCategory {
            case "Solo": questions = questions.filter({$0.category == .Solo})
            case "Ensemble": questions = questions.filter({$0.category == .Ensemble})
            case "All": break
            default: break
        }
        
        //decide the number of questions to be asked and choose which to ask first
        if numQuestionsSelected == "All" {
            numQuestions = questions.count
        } else {
            numQuestions = Int(numQuestionsSelected)!
        }
        pickQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //choose the next question or finish the game
    func pickQuestion() {//no repeats
        //TODO possibly shuffle answer locations - a possible addition but not simple to implement, especially allowing for possible picture answers
        if (questions.count > 0 && numAsked < numQuestions) {//continuing quiz, choose a question
            //sequential
            //qNumber = 0
            
            //random
            qNumber = Int(arc4random_uniform(UInt32(questions.count)))
            currentQuestion = questions[qNumber]
            numAsked += 1
            
            //set text and answers
            qLabel.text = currentQuestion.question
            answerNumber = currentQuestion.answer
            for i in 0..<answerButtons.count {
                answerButtons[i].setTitle(currentQuestion.answers[i], for: UIControlState.normal)
                //prevent repetition
            }
            //Allow for pause, resume, and replay from start of the associated excerpts
            let time = DispatchTime.now() + 1.5
            DispatchQueue.main.asyncAfter(deadline: time) {
                //wait for the question to load, then beging playing and set the control to show the correct state
                self.excerptSegmentedControl.selectedSegmentIndex = 0
                self.currentQuestion.excerpt.play()
            }
        } else {
            //finished!
            let time = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: time) {
                //display results
                let alertController = UIAlertController(title: "Finished", message: "You got \(self.numCorrect) out of \(self.numQuestions) questions correct", preferredStyle: .alert)
                //return to main menu
                let okAction = UIAlertAction(title: "Return to Menu", style: .default) {
                    (action: UIAlertAction!) in
                    self.performSegue(withIdentifier: "unwindToMenu", sender: self)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    //segmented control to allow replays of the excerpt and pausing if necessary
    @IBAction func excerptControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // play
            currentQuestion.excerpt.play()
        case 1: // pause
            currentQuestion.excerpt.pause()
        case 2: //stop
            currentQuestion.excerpt.stop()
        default:
            print("error")
        }
    }
    
    /*
     * When an answer is chosen, stop the current audio, indicate whether the answer was correct,
     * add to correct answer count, remove that question from the list, and pick the next question.
     */
    @IBAction func pressAnswerButton(_ sender: UIButton) {
        if (answerNumber == sender.tag) { //Correct Answer Chosen
            currentQuestion.excerpt.stop()
            numCorrect += 1
            showAlertMessage(title: "Correct!", message: "Next Question", delay: 0.5)
            questions.remove(at: qNumber)
            pickQuestion()
        } else { //Incorrect Answer Chosen
            currentQuestion.excerpt.stop()
            showAlertMessage(title: "Wrong Answer", message: "Try Again Next Time", delay: 0.5)
            questions.remove(at: qNumber)
            pickQuestion()
        }
    }
    
    //utility function to display alert messages asynchronously and with no actions associated
    //alerts display for the amount of time specified in 'delay'
    func showAlertMessage(title: String, message: String, delay: Double) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        let time = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: time) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    //initialize the content for all possible songs
    //ideally, this would be in a database. then only the songs chosen by the filter would be loaded and initialized
    func createQuestionList() {
        //Any spelling mistakes are likely attempts to match Irish spellings
        questions = [
            //Solo questions. All use the same wording to avoid users remembering answers based on the question itself. Exclusively instrumentation questions, not including exam questions featuring solos.
            Question(q: "Which instrument is playing?", aArray: ["Accordion","Fiddle","Tin Whistle","Harp"], a: 1, songName: "Irish_A_Ruin_Violin_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Harp","Concertina","Bouzouki","Guitar"], a: 2, songName: "Irish_Bay_Bouzouki_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Harp","Fiddle","Banjo","Uilleann Pipes"], a: 0, songName: "Irish_Breton_Harp_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Concertina","Banjo","Harp","Fiddle"], a: 2, songName: "Irish_Breton_Harp_07.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Fiddle","Accordion","Mandolin","Harp"], a: 3, songName: "Irish_Briongloiid_Harp_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bodhran","Spoons","Bass Drum","Tom Toms"], a: 0, songName: "Irish_Chante_Bodhran_03.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Banjo","Guitar","Fiddle","Harmonica"], a: 1, songName: "Irish_Chante_Guitar_02.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Melodeon","Fiddle","Flute","Accordion"], a: 0, songName: "Irish_Chante_Malodeon_03.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Accordion","Bodhran","Fiddle","Banjo"], a: 2, songName: "Irish_Chante_Violin_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Low Whistle","Tin Whistle","Flute","Uilleann Pipes"], a: 2, songName: "Irish_Chiann_Flute.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Flute","Fiddle","Bouzouki","Concertina"], a: 1, songName: "Irish_Chiann_Violin_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Uilleann Pipes","Whistle","Concertina","Flute"], a: 1, songName: "Irish_Chiann_Whistle_02.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bouzouki","Banjo","Concertina","Harpsichord"], a: 0, songName: "Irish_Cooley_Bouzouki.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bouzouki","Harpsichord","Fiddle","Harp"], a: 3, songName: "Irish_Delight_Harp_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Melodeon","Accordion","Piano","Uilleann Pipes"], a: 0, songName: "Irish_Dew_Melodeon_04.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bones","Bodhran","Spoons","Low Whistle"], a: 1, songName: "Irish_Frost_Bodhran_04.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Flute","Banjo","Bouzouki","Low Whistle"], a: 0, songName: "Irish_Frost_Flute_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Tin Whistle","Accordion","Flute","Harmonica"], a: 2, songName: "Irish_Frost_Flute_05.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Guitar","Banjo","Harp","Bouzouki"], a: 2, songName: "Irish_Frost_Harp_04.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bouzouki","Accordion","Flute","Fiddle"], a: 3, songName: "Irish_Frost_Violin_08.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Harpsichord","Guitar","Bodhran","Bouzouki"], a: 3, songName: "Irish_Ginger_Bouzouki_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Fiddle","Whistle","Concertina","Flute"], a: 0, songName: "Irish_Jig_Violin_04.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Drums","Piano","Bones","Bodhran"], a: 3, songName: "Irish_Land_Bodhran_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Flute","Harp","Low Whistle","Mandolin"], a: 1, songName: "Irish_Nag_Harp_01.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Mandolin","Banjo","Bodhran","Bones"], a: 0, songName: "Irish_Nag_Mandolin_02.caf", type: .Solo),
            Question(q: "Which instrument is playing?", aArray: ["Bouzouki","Accordion","Tenor Banjo","Harmonica"], a: 0, songName: "Irish_Reel_Bouzouki_02.caf", type: .Solo),
            //Ensemble questions. Much more specific to each individual piece. Mainly exam questions, even some solos.
            Question(q: "Which instrument first plays the melody?", aArray: ["Fiddle","Flute","Melodeon","Banjo"], a: 0, songName: "Chante.m4a", type: .Ensemble),
            Question(q: "Which instrument plays the melody second?", aArray: ["Fiddle","Harmonica","Melodeon","Guitar"], a: 2, songName: "Chante.m4a", type: .Ensemble),
            Question(q: "Which instrument never plays the accompaniment?", aArray: ["Fiddle","Banjo","Melodeon","Bodhran"], a: 1, songName: "Chante.m4a", type: .Ensemble),
            Question(q: "Which instruments are playing at the start?", aArray: ["Harp and Flute","Whistle and Fiddle","Fiddle and Harp","Flute and Whistle"], a: 2, songName: "Chiann.m4a", type: .Ensemble),
            Question(q: "Which instrument is the main accompaniment?", aArray: ["Fiddle","Harp","Flute","Guitar"], a: 1, songName: "Chiann.m4a", type: .Ensemble),
            Question(q: "Which instrument is playing the melody at the beginning?", aArray: ["Flute","Whistle","Harp","Fiddle"], a: 3, songName: "Chiann.m4a", type: .Ensemble),
            Question(q: "Which instrument does NOT play?", aArray: ["Fiddle","Banjo","Harmonica","Guitar"], a: 2, songName: "2003-5-1.m4a", type: .Ensemble),
            Question(q: "Which one of the following can be heard in this excerpt?", aArray: ["Changes of Key","Free Rhythm","Repeated Final Note","None of the Above"], a: 0, songName: "2003-5-1.m4a", type: .Ensemble),
            Question(q: "Which type of dance tune is this?", aArray: ["Hornpipe","Jig","Reel","Slip Jig"], a: 1, songName: "2003-5-1.m4a", type: .Ensemble),
            Question(q: "Which instrument plays the melody first?", aArray: ["Oboe","Trumpet","Clarinet","Horn"], a: 2, songName: "2003-5-3.m4a", type: .Ensemble),
            Question(q: "Which instrument plays the melody second?", aArray: ["Oboe","Trumpet","Clarinet","Horn"], a: 0, songName: "2003-5-3.m4a", type: .Ensemble),
            Question(q: "Which instrument plays the melody third?", aArray: ["Oboe","Trumpet","Clarinet","Horn"], a: 1, songName: "2003-5-3.m4a", type: .Ensemble),
            Question(q: "Which instrument is playing?", aArray: ["Harmonica","Fiddle","Uilleann Pipes","Accordion"], a: 3, songName: "2011-5-1.m4a", type: .Ensemble),
            Question(q: "This excerpt is an example of which type of tune?", aArray: ["Ballad","Slow Air","Macaronic","Polka"], a: 1, songName: "2011-5-1.m4a", type: .Ensemble),
            Question(q: "Which traditional feature is NOT heard in this excerpt?", aArray: ["Ornamentation","Flattened 7th","Drone","Wide Range"], a: 3, songName: "2011-5-1.m4a", type: .Ensemble),
            Question(q: "Which type of dance tune is this?", aArray: ["Jig","Reel","Hornpipe","Polka"], a: 1, songName: "2011-5-2.m4a", type: .Ensemble),
            Question(q: "Which time signature is associated with this dance tune?", aArray: ["2/2","6/8","9/8","12/8"], a: 0, songName: "2011-5-2.m4a", type: .Ensemble),
            Question(q: "Which sequence best matches the form of this tune?", aArray: ["ABC","ABA","ABCABA","ABCD"], a: 0, songName: "2011-5-2.m4a", type: .Ensemble),
            Question(q: "Which one of the following is featured in this excerpt?", aArray: ["Harmony","Free Rhythm","A Drone","Syncopation"], a: 2, songName: "2012-5-1.m4a", type: .Ensemble),
            Question(q: "Which type of dance tune is this?", aArray: ["Slip Jig","Jig","Reel","Hornpipe"], a: 0, songName: "2012-5-1.m4a", type: .Ensemble),
            Question(q: "Which time signature is associated with this dance tune?", aArray: ["3/4","12/8","9/8","6/8"], a: 2, songName: "2012-5-1.m4a", type: .Ensemble),
            Question(q: "Which traditional instrument is NOT heard in this excerpt?", aArray: ["Tin Whistle","Harp","Fiddle","Accordion"], a: 3, songName: "2012-5-2.m4a", type: .Ensemble),
            Question(q: "Which instrument is NOT heard in this excerpt?", aArray: ["Bones/Spoons","Harp","Piano","Bodhran"], a: 1, songName: "2012-5-3.m4a", type: .Ensemble),
            //code template to add a new question quickly
            //Question(q: "?", aArray: ["","","",""], a: 0, songName: ".m4a", type: .Ensemble),
        ]
    }
    
}

