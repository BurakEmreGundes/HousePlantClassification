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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController?.viewControllers)
    }
    
    

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
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model){ (request,error) in
            let classification = request.results?.first as? VNClassificationObservation
            
            self.navigationItem.title = classification?.identifier
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }catch {
            print(error)
        }
       
        
        
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
