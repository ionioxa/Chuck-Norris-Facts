//
//  ViewController.swift
//  Chuck Norris Facts
//
//  Created by Ion Ioxa on 2018-01-25.
//  Copyright © 2018 Ion Ioxa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class ViewController: UIViewController {

    let randomJokesURL = "http://api.icndb.com/jokes/random"
    var joke : String = ""
    var jokeId : Int = 0
    
    @IBOutlet weak var jokes: UILabel!
    @IBOutlet weak var jokesNumber: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getJokesData(url: randomJokesURL)
    }
    

    @IBAction func shareBtn(_ sender: UIButton) {
    }
    
    @IBAction func favoriteBtn(_ sender: UIButton) {
    }
    
    @IBAction func randomBtn(_ sender: UIButton) {
        self.getJokesData(url: randomJokesURL)
    }
    
    
    @IBAction func menuBtn(_ sender: UIButton) {
    }
    
    //MARK: - Networking
    /************************************************************************/
    func getJokesData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Success! Got the jokes")
                    let jokesJSON : JSON = JSON(response.result.value!)
                    self.updateJokes(json: jokesJSON)
                    print(jokesJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.jokes.text = "Connection Error"
                }
                
        }
        
    }
    
    //MARK: - JSON Parsing
    /************************************************************************/
    
    func updateJokes (json: JSON) {
        
        if let jokesResult = json["value"]["joke"].string {
            
            joke = String(jokesResult)
            jokes.text = "\(joke)"
            
        } else {
            
            jokes.text = "Hmm...No Jokes Available"
            
        }
        
        if let jokesId = json["value"]["id"].int {
            
            jokeId = Int(jokesId)
            jokesNumber.text = "#\(jokeId)"
            
        } else {
            
            jokesNumber.text = "..."
            
        }
    }
    
}

