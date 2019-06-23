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
        EditingText.text = NoteText
    }
    
    var NotesID : String = ""
    var NoteText : String = ""
    @IBOutlet weak var EditingText: UITextView!
    @IBAction func OnDoneEditing(_ sender: Any) {
        let db = Firestore.firestore()
        let userUID = FirebaseAuthManager.Singleton.UserUID
        NoteText = EditingText.text
        
        let lines = NoteText.components(separatedBy: "\n")
        let titleText = lines.indices.contains(0) ? lines[0]:NoteText
        
        let dict : [String:Any] = ["Title":titleText,
                                   "Context":  NoteText]
        if(NotesID == ""){
            //Using current time as note ID
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            NotesID = format.string(from: date)
        }
        
        db.collection("users").document(userUID).collection("Notes").document(NotesID).setData(dict)
        dismiss(animated: true, completion: nil)
    }
}
