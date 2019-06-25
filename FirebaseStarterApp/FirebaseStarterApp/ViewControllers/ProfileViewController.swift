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
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("images")
        if !fileManager.fileExists(atPath: paths){
            do {
                try fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }else{
            print("Already directory created.")
        }
    }
    
    func saveImageToDocumentDirectory() {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        
        let imageData = UIImage.jpegData(image!)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    
}
