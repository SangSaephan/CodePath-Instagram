//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Sang Saephan on 3/9/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var postImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        posterImageView.image = originalImage
        postImage = originalImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonPressed(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
        
        Post.postUserImage(image: postImage, withCaption: captionTextField.text, withCompletion: nil)
        tabBarController?.selectedIndex = 0
        posterImageView.image = nil
        captionTextField.text = ""
        
    }
    
}
