//
//  AuthoritySummaryViewController.swift
//  fsa-infinity
//
//  Created by Ben Foster on 25/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import UIKit

class AuthoritySummaryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var authorityLabel: UILabel!
    @IBOutlet weak var summaryTable: UITableView!
    
    var authority: String?
    
    var results: [String] = ["1", "2", "3", "4", "5", "Pass", "Exempt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = authority
        self.authorityLabel.text = authority! + " - Ratings"
        
        summaryTable.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell: RatingCell = summaryTable.dequeueReusableCell(withIdentifier: RatingCell.identifier) as! RatingCell
        
        // set the text from the data model
        cell.display(rating: results[indexPath.row], percentage: "55%")
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
