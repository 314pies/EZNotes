//
//  NoteEditorViewController.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/23.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class NoteEditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func OnDoneEditing(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
