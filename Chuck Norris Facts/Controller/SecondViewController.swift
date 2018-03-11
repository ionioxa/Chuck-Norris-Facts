//
//  SecondViewController.swift
//  Chuck Norris Facts
//
//  Created by Ion Ioxa on 2018-03-03.
//  Copyright © 2018 Ion Ioxa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var jokePassedOver : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        // Register the XIB file of the custom cell
        favoriteTableView.register(UINib(nibName: "CustomFavoriteJokeCell", bundle: nil), forCellReuseIdentifier: "favoriteJokeCell")
        
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteJokeCell", for: indexPath) as! CustomFavoriteJokeCell
        
        let jokesArray = ["First Message", "Secom,mnknkjnkjnkjnkjnkjnkjnkjnkjnkjnknkjnjnjnjknjnkjnkjnkjnknkjnkjnjknjknjknknjknknkjnkjnknjknknd Message", "Third Message"]
        
        cell.favoriteJoke.text = jokesArray[indexPath.row]
        
        return cell
    }
    
    // toDO: Declare configureTableView here:
    
    func configureTableView() {
        
       favoriteTableView.rowHeight = UITableViewAutomaticDimension
        favoriteTableView.estimatedRowHeight = 120.0
        
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
