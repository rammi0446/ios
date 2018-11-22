//
//  RestaurantMapViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-22.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class RestaurantMapViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
        let url = "https://opentable.herokuapp.com/api/restaurants?city=Toronto&per_page=5"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            (response) in
            
            // -- put your code below this line
            // set the center of the map
            let x = CLLocationCoordinate2DMake(43.6532, -79.3832)
            
            // pick a zoom level
            let y = MKCoordinateSpanMake(0.01, 0.01)
            
            // set the region property of the mapview
            let z = MKCoordinateRegionMake(x, y)
            self.mapView.setRegion(z, animated: true)
            
            
            
            // pins on the map
            if (response.result.isSuccess) {
                print("awesome, i got a response from the website!")
                print("Response from webiste: " )
                print(response.data)
                
                do {
                    let json = try JSON(data:response.data!)
                    print(json)
                   // print(">>>>>>>>>>>>>>>>>.\(json["restaurants"][0]["name"])")
                    let arr = [0 , 1, 2, 3, 4]
                  for i in arr
                    {
                    let pin = MKPointAnnotation()
                    // 2. Set the latitude / longitude of the pin
                    var lat = json["restaurants"][i]["lat"].double
                    var lng = json["restaurants"][i]["lng"].double
                    let x = CLLocationCoordinate2DMake(lat! , lng!)
                  
                    pin.coordinate = x
                    
                    // 3. OPTIONAL: add a information popup (a "bubble")
                    pin.title = json["restaurants"][i]["name"].string
                    
                    // 4. Show the pin on the map
                    self.mapView.addAnnotation(pin)
                    }
                }
                catch {
                    print ("Error while parsing JSON response")
                }
                
            }
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: Actions

    @IBAction func zoomInPressed(_ sender: Any) {
        
        print("zoom in!")
        
        // HINT: Check MapExamples/ViewController.swift
        var r = mapView.region
        
        print("Current zoom: \(r.span.latitudeDelta)")
        
        r.span.latitudeDelta = r.span.latitudeDelta / 4
        r.span.longitudeDelta = r.span.longitudeDelta / 4
        print("New zoom: \(r.span.latitudeDelta)")
        print("-=------")
        self.mapView.setRegion(r, animated: true)
    }
    
    @IBAction func zoomOutPressed(_ sender: Any) {
        // zoom out
        print("zoom out!")
        
        
        // HINT: Check MapExamples/ViewController.swift
        var r = mapView.region
        r.span.latitudeDelta = r.span.latitudeDelta * 2
        r.span.longitudeDelta = r.span.longitudeDelta * 2
        self.mapView.setRegion(r, animated: true)
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
