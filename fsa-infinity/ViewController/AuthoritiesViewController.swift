//
//  ViewController.swift
//  fsa-infinity
//
//  Created by Ben Foster on 24/08/2020.
//  Copyright © 2020 InfinityWorks. All rights reserved.
//

import UIKit

class AuthoritiesViewController: UITableViewController {

    var authorities: [Authority]?
    
    public var fsaClient: FSAClientProtocol = FSAClient(decoder: JSONDecoder())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.tableFooterView = UIView()
        
        let spinner = UIActivityIndicatorView()
        spinner.color = UIColor(named: "primary")
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        self.fsaClient.getAuthorities(resultHandler: {result in
            self.tableView.backgroundView = nil
            self.refreshControl?.endRefreshing()
            self.authorities = result
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.authorityRatingsSegueId, let controller = segue.destination as? AuthoritySummaryViewController, let authority = sender as? String {
            controller.authority = authority
        }
    }
}

extension AuthoritiesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return authorities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorityCell", for: indexPath)
        
        cell.textLabel?.text = authorities![indexPath.item].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndex = indexPath.row
        let selectedAuthorityName = authorities![rowIndex].name
        let selectedAuthorityId = authorities![rowIndex].id
        fsaClient.getEstablishmentByAuthority(authorityId: selectedAuthorityId, resultHandler:{ result in
            if result.isEmpty { return }
            print(result)
            //result.reduce{ $0 == 5 }
        })
        print("Authority " + selectedAuthorityName + " selected")
        performSegue(withIdentifier: Segues.authorityRatingsSegueId, sender: selectedAuthorityName)
    }
}

