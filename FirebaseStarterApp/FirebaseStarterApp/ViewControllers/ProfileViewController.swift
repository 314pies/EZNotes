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
        getProfileImage()
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
        saveProfileImage()
    }
    
    
    func saveProfileImage() {
        let fileManager = FileManager.default
        let paths = (getDirectoryPath() as NSString).appendingPathComponent("profile.jpg")
        let image = ProfileImage.image
        print(paths)
        let imageData = image?.jpegData(compressionQuality: 0.9)
        //let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getProfileImage(){
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent("profile.jpg")
        if fileManager.fileExists(atPath: imagePath){
            ProfileImage.image = UIImage(contentsOfFile: imagePath)
        } else {
            print("No Image")
        }
    }
}
