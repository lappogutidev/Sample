//
//  ViewController.swift
//  Sample
//
//  Created by Diego Gutierrez on 3/10/18.
//  Copyright © 2018 Diego Gutierrez. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import MediaPlayer
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    //
    //  ViewController.swift
    //  sdfasdafvd
    //
    //  Created by Pramodh Aryasomayajula on 3/10/18.
    //  Copyright © 2018 Pramodh Aryasomayajula. All rights reserved.
    //
        
    //Map
    @IBOutlet weak var map: MKMapView!
    
    let mapManager = CLLocationManager()
        
    func locationManager(_ mapManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.latitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
            
        self.map.showsUserLocation = true
    }
    //Date and Time
    let date = Date();
    let dateFormatter = DateFormatter();

    //UI Elements
    @IBOutlet weak var dateLabel: UILabel!
    
        
    //UI Management
    @IBAction func button(_ sender: UIButton) {
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        dateLabel.text = "\(dateFormatter.string(from: date))"
        
        //Map
        mapManager.delegate = self 
        mapManager.desiredAccuracy = kCLLocationAccuracyBest
        mapManager.requestWhenInUseAuthorization()
        mapManager.startUpdatingLocation()
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Get data from he attribute
    func getSample() {
        let request: NSFetchRequest = SampleEntity.fetchRequest()
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        do {
            let searchResults = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let searchResultsArray = searchResults.map { $0["sampleAttribute"] as! String}
            print("searchResultsArray", searchResultsArray)
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    // Save to the attribute
    func setSample() {
        let saveSample = SampleEntity(context: context)
        saveSample.sampleAttribute = "Save a new string."
        do {
            try context.save()
        } catch {
            print("Error with save: \(error)")
        }
    }
    
    // clear the attribute
    func resetSample() {
        let clearSample: NSFetchRequest = SampleEntity.fetchRequest()
        let deleteResults = NSBatchDeleteRequest(fetchRequest: clearSample as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try context.execute(deleteResults)
            try context.save()
        } catch {
            print("Error with save: \(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getSample()
        setSample()
        getSample()
        resetSample()
        getSample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

