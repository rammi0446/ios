//
//  MenuTableViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    //var username = ""
    var items = ["Restaurant Map", "Make a Reservation","Show Reservation"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        
        print("Person clicked in row number: \(i)")
        
        if (i == 0) {
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "map")
            self.navigationController?.pushViewController(vc1!, animated: true)
        }
        if(i == 1)
        {
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "res")
            self.navigationController?.pushViewController(vc1!, animated: true)
        }
        if(i == 2)
        {
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "show")
            self.navigationController?.pushViewController(vc1!, animated: true)
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("going to next page reservation")
//        let chatPage = segue.destination as! MakeReservationViewController
//        chatPage.username = self.username
    }
    

}
