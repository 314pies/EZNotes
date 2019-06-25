//
//  ProfileViewController.swift
//  FirebaseStarterApp
//
//  Created by Ian Chen on 2019/6/26.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnPickImageClck(_ sender: Any) {
        print("OnPickImageClck");
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        controller.allowsEditing = true
        present(controller,animated: true,completion: nil)
    }
    
    @IBOutlet weak var ProfileImage: UIImageView!
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        ProfileImage.image = image
        dismiss(animated: true, completion: nil)
    }
}
