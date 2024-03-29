//
//  AccessoriesTableViewController.swift
//  sample_ios_ea_bluetooth
//
//  Created by Marcel Raner on 09.09.19.
//  Copyright © 2019 Marcel Raner. All rights reserved.
//

import UIKit
import ExternalAccessory

class AccessoriesTableViewController: UITableViewController {

    var accessories = [EAAccessory]()

    @IBAction func refreshButtonPressed(_ sender: Any) {
        updateAccessories()
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        searchForAccessories()
    }

    func updateAccessories() {
        accessories = EAAccessoryManager.shared().connectedAccessories
        print("Accessories:", accessories)
        self.tableView.reloadData()
    }

    func searchForAccessories() {
        EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        updateAccessories()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accessoryCell", for: indexPath)

        // Configure the cell...
        let accessory = accessories[indexPath.row]
        cell.textLabel?.text = accessory.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        let detailsController = segue.destination as! AccessoryDetailsTableViewController

        guard segue.identifier == "showAccessoryDetails",
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let index = indexPath.row
        detailsController.accessory = accessories[index]
    }

}
