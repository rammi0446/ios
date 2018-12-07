//
//  SeeReservationsViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SeeReservationsViewController: UIViewController {
    var mapPokiName = ""
    var mapPokiHP = 0
    var mapPokiDefense = 0
    var mapPokiMoney = 0
    var mapPokiAttack = 0
    
    var userPokiName = ""
    var userPokiHP = 80
    var userPokiDefense = 1
    var userPokiMoney = 0
    var userPokiAttack = 4
    
    //MARK: Outlets
    @IBOutlet weak var textField: UITextView!
    @IBAction func attackUser(_ sender: Any) {
        print("user attacj to computer")
        if(mapPokiHP <= 0){
        print("you have to take poki to hospital")
        }
        else{
            mapPokiHP = mapPokiHP - userPokiAttack + mapPokiDefense;
            print("Hp left only of computer\(mapPokiHP)");
            
        }
        
    }
    
    @IBAction func attackComputer(_ sender: Any) {
        print("computer attacks to user")
        if(userPokiHP <= 0){
                print("you have to take poki to hospital");
        }
        else{
            userPokiHP = (userPokiHP - mapPokiAttack  + userPokiDefense) ;
            print("Hp left only of user is\(userPokiHP)");
        
            
        }
    }
    
    // MARK: Firebase variables
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("You are on the see reservations screen")
        
       let name = UserDefaults.standard.string(forKey: "pokName")
//        textField.text = name
        
        db = Firestore.firestore()
        
//        let settings = db.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        db.settings = settings

        let resRef = db.collection("mapPoki").whereField("name", isEqualTo: name)
        print("Querying database")
        resRef.getDocuments() {
           (snapshot, error) in

            if (error != nil) {
               print("Error getting results from query")
            }
            else {
                print("Got something!")
                print("Num items in database matching query: \(snapshot!.count)")
                var i = 0
                repeat{
                // 1. Get one result from database
                let results = snapshot!.documents
                let data = results[i].data()
                print(" computer Hp \(data["HP"]!)")
                print("attack \(data["Attack"]!)")
                print("Defense \(data["Defense"]!)")
                print("Money \(data["Money"]!)")
                    self.mapPokiHP = data["HP"]! as! Int
                    self.mapPokiName = data["name"]! as! String
                    self.mapPokiAttack = data["Attack"]! as! Int
                    self.mapPokiDefense = data["Defense"]! as! Int
                    self.mapPokiMoney = data["Money"]! as! Int
                    i = i+1
                }while(i < snapshot!.count)

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
