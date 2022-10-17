//
//  PlantSearchViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 16.10.2022.
//

import UIKit
import CoreML
import Vision

class PlantSearchViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        configureNavBar()
        configureLayoutAttributes()
    }
    
    
    private func configureLayoutAttributes(){
        selectImageButton.layer.cornerRadius = 12.0
    }
    
    private func configureNavBar(){
        self.navigationItem.title = "Bitkileri Keşfet"
        self.navigationController?.configureNavigationForBaseGreen()
    }
    

    private lazy var galleryPicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    private lazy var cameraPicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
        return picker
    }()
    
    

    @IBAction func tappedSelectImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Resim Seç", message: "Aşağıdaki seçenekleri kullanarak resim yukleyebilirsin!", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Kameradan Çek", style: .default, handler: { [weak self] action in
            guard let strongSelf = self else {return}
            strongSelf.present(strongSelf.cameraPicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galeriden Seç", style: .default, handler: { [weak self] action in
            guard let strongSelf = self else {return}
            strongSelf.present(strongSelf.galleryPicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Vazgeç", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    private func detect(image : CIImage){
        
    }
    
    @IBAction func tappedInfo(_ sender: Any) {
        print("screen for info plants")
    }
}

extension PlantSearchViewController :  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage{
            
            self.mainImageView.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Something went wrong.")
            }
            
            
            detect(image: ciImage)
        }
        
       dismiss(animated: true)
    }
}
