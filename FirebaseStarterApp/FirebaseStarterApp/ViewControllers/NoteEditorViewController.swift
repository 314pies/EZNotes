//
//  NoteEditorViewController.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/23.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit
import FirebaseFirestore
class NoteEditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var NotesID : String = ""
    @IBAction func OnDoneEditing(_ sender: Any) {
        let db = Firestore.firestore()
        let userUID = FirebaseAuthManager.Singleton.UserUID
       
        let dict : [String:Any] = ["NoteContext":  "Test Note"]
        db.collection("users").document(userUID).collection("Notes").document("CurrentTime").setData(dict)
        dismiss(animated: true, completion: nil)
    }
}
