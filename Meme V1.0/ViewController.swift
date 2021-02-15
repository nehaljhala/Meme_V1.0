//
//  ViewController.swift
//  Meme V1.0
//
//  Created by Nehal Jhala on 2/2/21.
//

import UIKit
// Create the meme
struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting font, style and color
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -3.0,
           ]
        TopTextField.defaultTextAttributes = memeTextAttributes
        BottomTextField.defaultTextAttributes = memeTextAttributes
        TopTextField.delegate = self
        BottomTextField.delegate = self
        TopTextField.textAlignment = .center
        BottomTextField.textAlignment = .center
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem( title: "share", style: .done, target: self, action: #selector(ViewController.shareButton(_:)))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField == TopTextField && TopTextField.text == "TOP"{
            TopTextField.text = ""
        }
        if textField == BottomTextField && BottomTextField.text == "BOTTOM"{
            BottomTextField.text = ""
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == TopTextField && TopTextField.text == ""{
            TopTextField.text = "TOP"
        }
        if textField == BottomTextField && BottomTextField.text == ""{
            BottomTextField.text = "BOTTOM"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
    //keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButtonOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera  )
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        //view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //pick image from camera
    @IBAction func cameraButton(_ sender: Any) {
        if !isCameraAvailable() {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    //pick image from album
    @IBAction func AlbumButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    //Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print(info)
        let _: UIImagePickerController.InfoKey
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        ImagePickerView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    //Tells the delegate that the user cancelled the pick operation
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    //meme
    func save()-> Meme {
         let myImage = Meme(topText: TopTextField.text!,
                        bottomText: BottomTextField.text!,
                        originalImage: ImagePickerView.image!,
                        memedImage: generateMemedImage())
        return myImage
    }
    func generateMemedImage() -> UIImage {
        
        //Hide ToolBar and NavBar
        navBar.isHidden = true
        toolBar.isHidden = true
     
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show ToolBar and Navbar
        navBar.isHidden = false
        toolBar.isHidden = false
        return memedImage
    }
    
    //Activity viewcontroller to share the meme
    
    @IBAction func shareButton(_ sender: Any) {
        
        let image = save()
        let controller = UIActivityViewController(activityItems: [image.memedImage], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        
    }
}

