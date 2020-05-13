//
//  ViewController.swift
//  PhotoMaster
//
//  Created by RS on 2020/05/12.
//  Copyright © 2020 osuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet var photo: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func presentPickerController(sourceType: UIImagePickerController.SourceType)  {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker,animated:  true,completion:  nil)
        }
    }
    
    func  imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        photo.image = info[.originalImage] as? UIImage
       
    }

    @IBAction func Tapcamera() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func Tapalbum() {
        presentPickerController(sourceType: .photoLibrary)
       
    }
    
    func  drawText(image: UIImage) -> UIImage {
        let text = "LifeisTech!"
        let TextFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial",size: 120)!,
            NSAttributedString.Key.foregroundColor: UIColor.red
        ]
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y:  0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let tectRect = CGRect(x: margin, y:  margin, width: image.size.width - margin, height: image.size.height - margin)
        text.draw(in: tectRect, withAttributes: TextFontAttributes)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        let maskImage = UIImage(named: "furo_ducky")!
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y:  0, width: image.size.width, height: image.size.height))
        let margin: CGFloat = 5.0
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.height - maskImage.size.height - margin,
                              width: maskImage.size.width, height: maskImage.size.height)
        maskImage.draw(in: maskRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func tapText() {
        if photo.image != nil {
            photo.image = drawText(image: photo.image!)
        } else {
            print("画像がありません")
        }
    }
        
    @IBAction func tapill() {
    if photo.image != nil {
        photo.image = drawMaskImage(image: photo.image!)
    } else {
        print("画像がありません")
      }
    }
    
    @IBAction func upload() {
        if photo.image != nil {
            let activityVC = UIActivityViewController(activityItems: [photo.image!,"#PhotoMaster"], applicationActivities: nil)
            self.present(activityVC, animated:  true, completion:  nil)
        } else {
            print("画像がありません")
          }
        
    }
    
    
    

}











