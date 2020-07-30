//
//  AddUserVC.swift
//  SQLiteCrud
//
//  Created by ksolves on 07/01/20.
//  Copyright © 2020 ksolves. All rights reserved.
//

import UIKit

class AddUserVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBAction func saveButtonClicked(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    // MARK: - Segue Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if textFirstName.text!.isEmpty || textLastName.text!.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: {(action) -> Void in alert.dismiss(animated: true, completion: nil)})
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     guard let button = sender as? UIBarButtonItem, button === saveBarButton else {
//         print("Save button was not pressed")
//         return
//     }
        let sqliteDB = SQLiteDb()
        let data = UserData(firstName: (textFirstName.text!), lastName: textLastName.text!)
        sqliteDB.create(userData: data)
    }

}
