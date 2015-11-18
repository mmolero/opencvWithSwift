//
//  ViewController.swift
//  opencvWithSwift
//
//  Created by Miguel Molero on 18/11/15.
//  Copyright © 2015 Miguel Molero. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var testImage: UIImage?
    var rawImage: UIImage?
    
    
    @IBOutlet var imagePicked: UIImageView!
    @IBOutlet var filterButton: UIButton!
    
    
    @IBAction func gallery(sender: AnyObject) {
        // photos from the collections
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
        
    
    }
    
    @IBAction func undo(sender: AnyObject) {
        
        if let testImage = rawImage {
            imagePicked.image = testImage
        }

        
    }
    
    //signal activated when UIImagePickerController finishes
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //Once the image is picked, this signal is activated
        print("Image Selected")
        self.dismissViewControllerAnimated(true, completion: nil)
       
        imagePicked.image = image
        rawImage  = image
    }
    
    
    @IBAction func filterMe(sender: AnyObject) {
        
        if let testImage = rawImage {
            
            let _image: ObjFilter = ObjFilter()
            imagePicked.image  = _image.processImage(testImage)
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

