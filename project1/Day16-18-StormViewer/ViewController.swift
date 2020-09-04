//
//  ViewController.swift
//  Day16-18-StormViewer
//
//  Created by Ashlee Muscroft on 01/09/2020.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    let cellFontSize: CGFloat = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavBar()
        loadImages()
    }

    private func setupNavBar() {
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadImages () {
        let fm = FileManager()
        let path = Bundle.main.resourcePath!
        let nsslImages = try! fm.contentsOfDirectory(atPath: path)
        pictures = nsslImages.filter { $0.hasPrefix("nssl") }.sorted()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // map each element of picture to a basic table cell
        // set the cell text to the item name and return the cell at indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
            //indexPath also contains section in its datatype
        if let cellLabel = cell.textLabel {
            cellLabel.text = pictures[indexPath.row]
            //copy font but increase size 
            cellLabel.font = cellLabel.font.withSize(cellFontSize)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        if let detailViewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
        detailViewController.selectedImage = pictures[indexPath.row]
            detailViewController.title = String(format: "Picture %d of %d", indexPath.row + 1, pictures.endIndex)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

