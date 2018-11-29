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
import FirebaseFirestore


class RestaurantMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // Mark: Firestore variables
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
        
       db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        self.mapView.delegate = self
        
        
        // set the center of the map
        let x = CLLocationCoordinate2DMake(43.6532, -79.3832)
        
        // pick a zoom level
        let y = MKCoordinateSpanMake(0.05, 0.05)
        
        // set the region property of the mapview
        let z = MKCoordinateRegionMake(x, y)
        self.mapView.setRegion(z, animated: true)

        func generateRandomLocation(lat: CLLocationDegrees, lng: CLLocationDegrees){
          
      
            var arr = [1, 2, 3, 4, 5]
            for i in arr{
                var latnew = 0.0
                var lngnew = 0.0
                //var  c = String(format:"%0.1d", arc4random_uniform(5))
                var c = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
                print(c)
                if(i <= 3)
               {
                latnew = lat + Double(c)
                lngnew = lng + Double(c)
                }
                else
               {
                latnew = lat - Double(c)
                lngnew = lng + Double(c)
                }
              
            print("The Lat are :- ")
            print(latnew)
            print("The Lng are :- ")
            print(lngnew)
                
            let pin = MKPointAnnotation()
                // 2. Set the latitude / longitude of the pin
               
                let x = CLLocationCoordinate2DMake(latnew , lngnew)
                pin.coordinate = x
                pin.title = ""
                // 3. OPTIONAL: add a information popup (a "bubble")
                switch i {
                case 1:
                   pin.title = "Pikachu"
                   print("save into firebase database")
                   let resRef = db.collection("mapPoki").document().setData([
                    "id" : i,
                    "lat" : latnew,
                    "lng" : lngnew,
                    "name" : pin.title,
                    "HP" : 60,
                    "Attack" : 7,
                    "Defense" : 12,
                    "Money" : 0
                    ])
                case 2:
                    pin.title = "Meotwo"
                    let resRef = db.collection("mapPoki").document().setData([
                        "id" : i,
                        "lat" : latnew,
                        "lng" : lngnew,
                        "name" : pin.title,
                        "HP" : 50,
                        "Attack" : 5,
                        "Defense" : 10,
                        "Money" : 0
                    ])
                case 3:
                    pin.title = "Charmander"
                    let resRef = db.collection("mapPoki").document().setData([
                        "id" : i,
                        "lat" : latnew,
                        "lng" : lngnew,
                        "name" : pin.title,
                        "HP" : 40,
                        "Attack" : 4,
                        "Defense" : 9,
                        "Money" : 0
                    ])
                    
                case 4:
                     pin.title = "Squirtle"
                     let resRef = db.collection("mapPoki").document().setData([
                        "id" : i,
                        "lat" : latnew,
                        "lng" : lngnew,
                        "name" : pin.title,
                        "HP" : 35,
                        "Attack" : 4,
                        "Defense" : 8,
                        "Money" : 0
                    ])
                    
                case 5:
                    pin.title = "Mew"
                    let resRef = db.collection("mapPoki").document().setData([
                        "id" : i,
                        "lat" : latnew,
                        "lng" : lngnew,
                        "name" : pin.title,
                        "HP" : 30,
                        "Attack" : 3,
                        "Defense" : 7,
                        "Money" : 0
                    ])
                    default:
                   pin.title = "pokemon\(i)"
                }
                
                // 4. Show the pin on the map
                self.mapView.addAnnotation(pin)
                
            }
        }

            generateRandomLocation(lat: 43.6532, lng: -79.3832)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation is clicked")
        
        print(view.annotation?.title!)
        UserDefaults.standard.set(view.annotation?.title, forKey: "pokName")
        
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "show")
        self.navigationController?.pushViewController(vc1!, animated: true)
        
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
 //   }
    

}
