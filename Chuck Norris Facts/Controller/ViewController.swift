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
import Social


class ViewController: UIViewController {

    let randomJokesURL = "http://api.icndb.com/jokes/random"
    var joke : String = ""
    var jokeId : Int = 0
    var favoriteJokes : [String] = []
    let defaults = UserDefaults.standard

//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Jokes.plist")
    
    @IBOutlet weak var jokes: UILabel!
    @IBOutlet weak var jokesNumber: UILabel!
    @IBOutlet weak var favoriteImage: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        if let favoriteJokesArray = defaults.array(forKey: "JokesArray") as? [String] {
            favoriteJokes = favoriteJokesArray
        }
//        print(dataFilePath)
        
        self.getJokesData(url: randomJokesURL)
    }
    
    //MARK: - Sharing Button
    /************************************************************************/
    @IBAction func shareBtn(_ sender: UIButton) {
        
        let activityController = UIActivityViewController(activityItems: [jokes.text!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
    }
    
    //MARK: - Favorite Button
    /************************************************************************/
    @IBAction func favoriteBtn(_ sender: UIButton) {
        
        if sender.currentImage == #imageLiteral(resourceName: "starempty") {
            
            favoriteJokes.append(jokes.text!)
            
            self.defaults.set(self.favoriteJokes, forKey: "JokesArray")
            
//            let encoder = PropertyListEncoder()
//
//            do {
//            let data = try encoder.encode(self.favoriteJokes)
//            try data.write(to: self.dataFilePath!)
//            }
//            catch {
//                print("Error encoding jokes array, \(error)")
//            }
            print(favoriteJokes)
        } else {
            //
        }

        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "starfilled"), offImage: #imageLiteral(resourceName: "starempty"))
        
    }
    
    //MARK: - Random Jokes Button
    /************************************************************************/
    @IBAction func randomBtn(_ sender: UIButton) {
        self.getJokesData(url: randomJokesURL)
        favoriteImage.setImage(#imageLiteral(resourceName: "starempty"), for: .normal)
    }
    
    
    @IBAction func menuBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    
    
    //MARK: - Created Toggle Method for the Favorite image
    /************************************************************************/
    func toggleButton (button: UIButton, onImage: UIImage, offImage: UIImage) {
        
        if button.currentImage == offImage {
            button.setImage(onImage, for: .normal)
        } else {
            button.setImage(offImage, for: .normal)
        }
        
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
            
            let correctJokes = joke.replacingOccurrences(of: "&quot;", with: "\"", options: .literal, range: nil)
            
            jokes.text = "\(correctJokes)"
            
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
    
    //MARK: - Segue Data Transfer
    /************************************************************************/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSecondScreen" {
            
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.jokesPassed = favoriteJokes
        }
    }
    
}

