
//  ViewController.swift
//  Meme V1.0
//  Created by Nehal Jhala on 2/2/21.

import UIKit

// Create the meme
struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
}
var meme:Meme?

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate, UITextFieldDelegate  {
    
    
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var Cancel: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(tf: topTextField, text: "TOP")
        setupTextField(tf: bottomTextField, text: "BOTTOM")
        print("view controller loaded")
    }
    
    //Setting the Textfields
    func setupTextField(tf: UITextField, text: String) {
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -4.0,
    ]
        tf.defaultTextAttributes = memeTextAttributes
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
        Cancel.isEnabled = true
        shareButton.isEnabled = false
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if textField == topTextField && topTextField.text == "TOP"{
            topTextField.text = ""
    }
        if textField == bottomTextField && bottomTextField.text == "BOTTOM"{
            bottomTextField.text = ""
    }
 }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == topTextField && topTextField.text == ""{
            topTextField.text = "TOP"
    }
        if textField == bottomTextField && bottomTextField.text == ""{
           bottomTextField.text = "BOTTOM"
    }
 }
    func textFieldShouldReturn(_ textField: UITextField)-> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    // Cancel the selection
    @IBAction func cancelSelection(_ sender: Any) {
        shareButton.isEnabled = false
        imagePickerView.image = nil
        dismiss(animated: true, completion:nil)
        navigationController?.popViewController(animated: true)
        
    }
    
    // Keyboard settings
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButtonOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera  )
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_notification:Notification) {
        if bottomTextField.isFirstResponder{
        view.frame.origin.y = 0
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Choose image from album or camera.
    func chooseImageFromPhotoOrCamera(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraButton(_ sender: Any) {
      if !isCameraAvailable() {
            return
    }
        chooseImageFromPhotoOrCamera(source:.camera)
    }
    @IBAction func AlbumButton(_ sender: Any) {
        chooseImageFromPhotoOrCamera(source:.photoLibrary)
    }
    
    // Disable the camera
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    // Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let _: UIImagePickerController.InfoKey
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagePickerView.image = image
        shareButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    // Tells the delegate that the user cancelled the pick operation
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    // Generate a meme image
    func save(){
        let meme = Meme(topText: topTextField.text!,
            bottomText: bottomTextField.text!,
            originalImage: imagePickerView.image!,
            memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("save memecount: \(appDelegate.memes.count)")
        dismiss(animated: true, completion: nil)
    }
    func generateMemedImage() -> UIImage {
        
        // Hide ToolBar and NavBar
        navBar.isHidden = true
        toolBar.isHidden = true
     
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show ToolBar and Navbar
        navBar.isHidden = false
        toolBar.isHidden = false
        return memedImage
    }
    
    // Activity viewcontroller to share the meme
    @IBAction func shareImage(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller,animated: true, completion: nil)
        controller.completionWithItemsHandler = {
            (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed && error == nil {
                self.save()
            }
        }
    }
}


