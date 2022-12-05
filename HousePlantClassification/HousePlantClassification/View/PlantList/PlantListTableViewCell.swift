//
//  PlantListTableViewCell.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 2.12.2022.
//

import UIKit

class PlantListTableViewCell: UITableViewCell, ClassNameGettable {
    
    static let cellId = "PlantListTableViewCell"
    
    @IBOutlet weak var hearthButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        contentView.cornerRadius = 12.0
    }
    
    @IBAction func tappedFavouriteButton(_ sender: Any) {
        hearthButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
