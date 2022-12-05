//
//  PlantListViewController.swift
//  HousePlantClassification
//
//  Created by Burak Emre gündeş on 26.10.2022.
//

import UIKit

class PlantListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    
    var user : User = User(email: "user@gmail.com", password: "123456")
    var user2 : User = User(email: "user2@gmail.com", password: "123456")
    
    var flower : Flower = Flower(flowerID: "Flower1ID", flowerName: "Flower1", flowerDescription: "Flower1Desc", flowerColor: "Flower1Color")
    
    var flower2 : Flower = Flower(flowerID: "Flower2ID", flowerName: "Flower2", flowerDescription: "Flower2Desc", flowerColor: "Flower2Color")
    
    
    lazy var userSearchFlower : UserSearchFlower = UserSearchFlower(user: user, searchID: "search1", userFlower: flower)
    lazy var userSearchFlower2 : UserSearchFlower = UserSearchFlower(user: user2, searchID: "search2", userFlower: flower2)
    
    
    lazy var userSearchFlowers : [UserSearchFlower] = [userSearchFlower,userSearchFlower2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @IBAction func tappedPlantDetails(_ sender: Any) {
        
        let sb = UIStoryboard(name: "PlantDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "plantDetailVC") as? PlantDetailViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController?.viewControllers)
    }
    
    private func configure(){
        configureNavBar()
        configureTableView()
    }
    
    private func configureNavBar(){
        self.navigationItem.title = "Aranılan Bitkiler"
        self.navigationController?.configureNavigationForBaseGreen()
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(with: PlantListTableViewCell.className)
    }


}

extension PlantListViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlantListTableViewCell", for: indexPath) as? PlantListTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "PlantDetail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "plantDetailVC") as? PlantDetailViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
}
