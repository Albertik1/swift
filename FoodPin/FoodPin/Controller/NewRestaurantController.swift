//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/12/17.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var restaurant: RestaurantMO!
    var restaurantToUpdate: RestaurantMO?
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 5.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if restaurantToUpdate != nil {
            loadOldData()
        }
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    // MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - ImagePickerController Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        //set constraints here
        addImageLayoutConstraints()
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        //not necessary to check empty input because of option type for each field
        
        //        if nameTextField.text == "" || typeTextField.text == "" || addressTextField.text == "" || phoneTextField.text == "" || descriptionTextView.text == "" {
        //            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
        //            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //            alertController.addAction(alertAction)
        //            present(alertController, animated: true, completion: nil)
        //
        //            return
        //        }
        
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            if restaurantToUpdate == nil { //add new data
                restaurant = RestaurantMO(context: context)
                restaurant.isVisited = false
            }
            else { // edit old data
                restaurant = restaurantToUpdate
            }
            
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = addressTextField.text
            restaurant.phone = phoneTextField.text
            restaurant.summary = descriptionTextView.text
            if let restaurantImage = photoImageView.image {
                restaurant.image = restaurantImage.pngData()
            }
            
            //print("Saving data to context ...")
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    private func loadOldData() {
        nameTextField.text = restaurantToUpdate?.name
        typeTextField.text = restaurantToUpdate?.type
        addressTextField.text = restaurantToUpdate?.location
        phoneTextField.text = restaurantToUpdate?.phone
        descriptionTextView.text = restaurantToUpdate?.summary
        if let restaurantImageName = restaurantToUpdate?.image {
            photoImageView.image = UIImage(data: restaurantImageName as Data)
            addImageLayoutConstraints()
        }
    }
    
    private func addImageLayoutConstraints() {
        let leadingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView as Any, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
    }
    
    
}
