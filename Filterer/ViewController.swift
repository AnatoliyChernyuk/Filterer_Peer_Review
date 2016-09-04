//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    var sourceImage: UIImage?
    var isFilterSelected: Bool?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryImageView: UIImageView!
    
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var redButton: UIButton!
    @IBOutlet var greenButton: UIButton!
    @IBOutlet var blueButton: UIButton!
    @IBOutlet var yellowButton: UIButton!
    @IBOutlet var purpleButton: UIButton!
    @IBOutlet var originalImageLabel: UILabel!
    
    
    @IBOutlet var onCompare: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        if isFilterSelected == false || isFilterSelected == nil {
            sourceImage = imageView.image
        }
        
        
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            isFilterSelected = nil
            sourceImage = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
            isFilterSelected = nil
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    //MARK: Secondary view methods
    func showSecondaryView() {
        view.addSubview(secondaryImageView)
        
        secondaryImageView.image = filteredImage
        
        self.secondaryImageView.alpha = 0
        UIView.animateWithDuration(0.8) {
            self.secondaryImageView.alpha = 1.0
        }
    }
    
    func hideSecondaryView() {
        UIView.animateWithDuration(0.8, animations: {
            self.secondaryImageView.alpha = 0
        }) { completed in
            if completed == true {
                self.secondaryImageView.removeFromSuperview()
            }
        }
    }
    
    
    
    //MARK: Filter buttons
    @IBAction func onRed(sender: UIButton) {
        isFilterSelected = true
        let red = AmplifyRed(intensity: 100)
        let filteredPicture = sourceImage
        filteredImage = imageProcessor.applySingleFilter(filteredPicture!, filter: red)
        imageView.image = filteredImage
        //showSecondaryView()
        
    }
    
    @IBAction func onGreen(sender: UIButton) {
        isFilterSelected = true
        let green = AmplifyGreen(intensity: 100)
        let filteredPicture = sourceImage
        filteredImage = imageProcessor.applySingleFilter(filteredPicture!, filter: green)
        imageView.image = filteredImage
        //showSecondaryView()
    }
    
    @IBAction func onBlue(sender: UIButton) {
        isFilterSelected = true
        let blue = AmplifyBlue(intensity: 100)
        let filteredPicture = sourceImage
        filteredImage = imageProcessor.applySingleFilter(filteredPicture!, filter: blue)
        imageView.image = filteredImage
        //showSecondaryView()
    }
    
    @IBAction func onYellow(sender: AnyObject) {
        isFilterSelected = true
        let yellow = AmplifyYellow(intensity: 100)
        let filteredPicture = sourceImage
        filteredImage = imageProcessor.applySingleFilter(filteredPicture!, filter: yellow)
        imageView.image = filteredImage
        //showSecondaryView()
    }
    
    @IBAction func onPurple(sender: UIButton) {
        isFilterSelected = true
        let purple = AmplifyPurple(intensity: 100)
        let filteredPicture = sourceImage
        filteredImage = imageProcessor.applySingleFilter(filteredPicture!, filter: purple)
        imageView.image = filteredImage
        //showSecondaryView()
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if isFilterSelected == true {
            isFilterSelected = false
            imageView.image = sourceImage
            //hideSecondaryView()
            originalImageLabel.alpha = 1
        } else if isFilterSelected == false {
            isFilterSelected = true
            imageView.image = filteredImage
            originalImageLabel.alpha = 0
            //showSecondaryView()
        }
    }
    
    //MARK: Compare touch toggle
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if isFilterSelected == true {
            imageView.image = sourceImage
            //hideSecondaryView()
            originalImageLabel.alpha = 1
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if isFilterSelected == true {
            imageView.image = filteredImage
            //showSecondaryView()
            originalImageLabel.alpha = 0
        }
    }
    
    

}



