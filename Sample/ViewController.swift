//
//  ViewController.swift
//  Sample
//
//  Created by Diego Gutierrez on 3/10/18.
//  Copyright © 2018 Diego Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
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

