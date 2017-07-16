//
//  Question.swift
//  Aural Exam Practice
//
//  Created by Bridget Bailey on 4/18/17.
//  Copyright © 2017 Bridget Bailey. All rights reserved.
//

import Foundation
//data structure to organize question information
class Question: NSObject {
    
    var question : String!//question text
    var answers : [String]!//array of possible answers
    var answer : Int!//index of correct answer
    var excerpt : Excerpt//associated music
    var category : QuestionCategory//associated question category
    
    //Future question types might include Irish dance tunes and vocal pieces
    //or classical instrumentation and set works (e.g. Mozart, Berlioz, Deane, Beatles)
    //some questions in teh ensemble category could also fit into these categories but I left it this way for design simplicity
    //Ensemble effectively means exam questions while Solo is short solo-instrument loops with the generic question
    enum QuestionCategory {
        case Solo
        case Ensemble
    }
    
    //constructor for the question class
    init(q: String, aArray: [String], a: Int, songName: String, type: QuestionCategory) {
        question = q
        answers = aArray
        answer = a
        //initialize the excerpt
        excerpt = Excerpt(songName)
        category = type
    }



}
