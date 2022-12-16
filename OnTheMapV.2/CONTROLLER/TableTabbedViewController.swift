//
//  TableTabbedViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 13/12/2022.
//

import Foundation
import UIKit

class TableTabbedViewController: UIViewController {
    
    
    // MARK: outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
    
extension TableTabbedViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: 1. tableView numberOfRowsInSection
    // to determine the number of rows in Table View based on .count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInformationModel.studentLocation.count
    }
    
    // MARK: 2.a tableView cellForRowAt integrating custom table view cell
    // to fill our cells with data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationTableCell") ?? UITableViewCell()
        
        // let studentPost = studentInformationModel.studentLocation[(indexPath as NSIndexPath).row]
        let studentPost = studentInformationModel.studentLocation[indexPath.row]
        
        var cellContent = cell.defaultContentConfiguration() // configure and Customize content of cell
        cellContent.text = "\(studentPost.firstName) \(studentPost.lastName)"
        cellContent.secondaryText = "\(studentPost.mediaURL)"
        cellContent.image = UIImage(named: "Apps-Github")
        
        cell.contentConfiguration = cellContent
        return cell
    }
    
    // MARK: 3. tableView didSelectRowAt
    // detail shown when selecting row ~ url is opened
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentPost = studentInformationModel.studentLocation[indexPath.row]
        openURLLink(urlString: studentPost.mediaURL)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Main.storyboard set up
// option + 2fingerClick  on Table View / drag&drop dataSource and delegate to tableTabbedView
