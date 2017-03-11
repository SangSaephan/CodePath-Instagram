//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Sang Saephan on 3/9/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import EZLoadingActivity

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var postImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "NoteWorthy", size: 22)!]
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
        
        EZLoadingActivity.show("Uploading...", disableUI: true)
        self.view.alpha = 0.2
        
        Post.postUserImage(image: postImage, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            if success {
                EZLoadingActivity.hide(true, animated: true)
                self.tabBarController?.selectedIndex = 0
                self.posterImageView.image = nil
                self.captionTextField.text = ""
                self.view.alpha = 1
            } else {
                EZLoadingActivity.hide(false, animated: true)
                self.view.alpha = 1
            }
        }
        
    }
    
}
