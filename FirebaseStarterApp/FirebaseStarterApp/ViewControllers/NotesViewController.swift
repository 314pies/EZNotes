//
//  NotesViewController.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/23.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBAction func SwitchNoteView(_ sender: Any) {
        if(NotesTableView.isHidden){
            NotesTableView.isHidden = false
            NotesCollectionView.isHidden = true
        }else{
            NotesTableView.isHidden = true
            NotesCollectionView.isHidden = false
        }
    }
    class NoteCellData{
        init(title:String,id:String,context:String) {
            self.Title = title
            self.ID = id
            self.Context = context
        }
        var Title : String
        var ID : String
        var Context : String
    }
    
    @IBOutlet weak var NotesTableView: UITableView!
    
    @IBOutlet weak var NotesCollectionView: UICollectionView!
    
    
    var Notes : Array<NoteCellData> = []
    
    func fetchNotes() {
        let db = Firestore.firestore()
        let userUID = FirebaseAuthManager.Singleton.UserUID
        
        db.collection("users").document(userUID).collection("Notes").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.Notes.removeAll()
                for document in querySnapshot.documents {
                    
                    self.Notes.append(NoteCellData(
                        title: document.data()["Title"] as! String,
                        id: document.documentID,
                        context: document.data()["Context"] as! String ))
                    self.NotesTableView.reloadData()
                    self.NotesCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
        //self.NotesCollectionView.register(UICollectionView.self, forCellWithReuseIdentifier: "CollNotescell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchNotes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as!NoteTableViewCell
        let cellTitle = "-" + Notes[indexPath.row].Title;
        cell.setTitle(titleText: cellTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "NoteEditor") {
            (controller as! NoteEditorViewController).NotesID = Notes[indexPath.row].ID
            (controller as! NoteEditorViewController).NoteText = Notes[indexPath.row].Context
            //(controller as! NoteEditorViewController).EditingText.text = Notes[indexPath.row].Context
            present(controller, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //Delete Note
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == .delete){
            let userUID = FirebaseAuthManager.Singleton.UserUID
            let NotesID = Notes[indexPath.row].ID
            let db = Firestore.firestore()
            db.collection("users").document(userUID).collection("Notes").document(NotesID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    self.fetchNotes()
                    print("Document successfully removed!")
                }
            }
            print("Deleted")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return Notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollNotescell", for: indexPath) as!NoteCollectionViewCell
        let cellTitle = "-" + Notes[indexPath.row].Title;
        cell.setTitle(titleText: cellTitle)
        return cell
    }
    
    
    @IBAction func onAddNoteClicked(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "NoteEditor") {
            (controller as! NoteEditorViewController).NotesID = ""
            (controller as! NoteEditorViewController).NoteText = ""
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSighnOutClicked(_ sender: Any) {
        
        var message = "";
        FirebaseAuthManager.Singleton.signOut(){[weak self] (success) in
            guard let `self` = self else { return }
            if(success){
                
                self.dismiss(animated: true, completion: nil)
                message = "Logout success."
            }else{
                message = "Log out failed."
            }
            //let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            //alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
    }
    
}
