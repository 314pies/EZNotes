//
//  NotesViewController.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/23.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var NotesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as!NoteTableViewCell
        cell.setTitle(titleText: "test: "+String(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "NoteEditor") {
            present(controller, animated: true, completion: nil)
        }
    }
}
