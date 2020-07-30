//
//  UserTableVC.swift
//  SQLiteCrud
//
//  Created by ksolves on 07/01/20.
//  Copyright © 2020 ksolves. All rights reserved.
//

import UIKit

class UserTableVC: UITableViewController {
    @IBOutlet var userdataTableView: UITableView!
    var arrayUserData = [UserData] ()
    let sqliteDB = SQLiteDb()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        
        arrayUserData = sqliteDB.read()
        //updateData()
        //userdataTableView.reloadData()
        //deleteData()
        //userdataTableView.reloadData()
    }
    
    // MARK: - Methods
    func updateData() {
        let userDataToUpdate = UserData(firstName: "Singh", lastName: "Sri")
        sqliteDB.update(userData: userDataToUpdate)
    }
    
    func deleteData() {
        let userDataToDelete = UserData(firstName: "Singh", lastName: "Sri")
        sqliteDB.delete(userData: userDataToDelete)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayUserData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as? UserTableViewCell else {
            fatalError("Dequeued cell is not an instance of UserTableViewCell")
        }

        let data = arrayUserData[indexPath.row]
        cell.textfirstName.text = data.firstName
        cell.textLastName.text = data.lastName
        
        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
