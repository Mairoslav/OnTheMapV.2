//
//  TableTabbedViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 13/12/2022.
//

import Foundation
import UIKit

// MARK: create a custom table view cell
// cell that contains image, title and subtitle
class TableViewCell: UITableViewCell {
    // for "Table View Cell" in Identity Inspector under Custom Class/Class write "TableViewCell" ~ as per name of this Class
    static let identifier = "locationTableCell"
    
    // the objects we need:
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
}

class TableTabbedViewController: UIViewController {
    
    // MARK: outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData() // table is updated also without this line, see comment B.11. in MapTabbedViewController.swift
        print("🔳 TableTabbedView was selected first time and re/loaded") // note that once data are downloaded within MapTabbedView, after first time opening the TableTabbedView they are re/loaded also here.
    }
    
}
    
extension TableTabbedViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: 1. tableView numberOfRowsInSection
    // to determine the number of rows in Table View based on .count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInformationModel.studentLocation.count 
    }
    
    // MARK: 2.a tableView cellForRowAt integrating custom table view cell
    // to fill our cells with data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationTableCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        let studentPost = StudentInformationModel.studentLocation[indexPath.row]
        
        cell.userImage.image = UIImage(named: "Apps-Itsycal")
        cell.titleLabel.text = "\(studentPost.firstName) \(studentPost.lastName)" // B.10. table view has a row for each downloaded record with the student’s name displayed
        cell.subtitleLabel.text = "\(studentPost.mediaURL)"
        
        return cell
    }
    
    // MARK: 3. tableView didSelectRowAt
    // detail shown when selecting row ~ url is opened
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentPost = StudentInformationModel.studentLocation[indexPath.row]
        openURLLink(urlString: studentPost.mediaURL) // B.12. When a row in the table is tapped, does the app open Safari to the student’s link
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Main.storyboard set up
// option + 2fingerClick  on Table View / drag&drop dataSource and delegate to tableTabbedView
