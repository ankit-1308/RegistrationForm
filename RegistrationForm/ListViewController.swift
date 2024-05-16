////
////  ListViewController.swift
////  RegistrationForm
////
////  Created by OLX on 15/05/24.


import UIKit

class ListViewController: UIViewController {
    
    var users = [User]()
    let tableView = UITableView()
    
    init() {
        print("Initialized")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "User List"
        
        view.backgroundColor = UIColor.yellow
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor)
        ])
//        tableView.frame = view.bounds
       
        tableView.dataSource = self
        tableView.delegate = self
    
        tableView.register(customCell.self, forCellReuseIdentifier: "customCell")
        
        loadUsers()
        
//        let popButton = UIButton(frame: CGRect(x: 280, y: 50, width: 150, height: 50))
//        popButton.setTitle("Back", for: .normal)
//        popButton.setTitleColor(.red, for: .normal)
//        popButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
//        view.addSubview(popButton)
        
   
        
        
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    
    
    func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            self.users = users
            tableView.reloadData()
        } else {
            print("Failed to load users or no users found")
        }
    }
}

class customCell: UITableViewCell {
    
    
    let testLabel = UILabel()
    let name = UILabel(frame: CGRect(x: 120, y: 20, width: 200, height: 30))
    let phoneNumber = UILabel(frame: CGRect(x: 120, y: 60, width: 200, height: 30))
    let email = UILabel(frame: CGRect(x: 120, y: 80, width: 200, height: 30))
    let dob = UILabel(frame: CGRect(x: 120, y: 120, width: 200, height: 30))
    let gender = UILabel(frame: CGRect(x: 120, y: 160, width: 200, height: 30))
    let food = UILabel(frame: CGRect(x: 120, y: 200, width: 200, height: 30))
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)
        addSubview(phoneNumber)
        addSubview(email)
        addSubview(dob)
        addSubview(gender)
        addSubview(food)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListViewController: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return users.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell
        let user = users[indexPath.row]
        
        cell.name.text = "Name: \(user.name)"
        cell.phoneNumber.text = "Phone Number: \(user.phoneNumber)"
        cell.email.text = "Email: \(user.emailId)"
        cell.dob.text = "DOB: \(user.dob)"
        cell.gender.text = "Gender: \(user.gender)"
        cell.food.text = "Food: \(user.food)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        
        return 300.0
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
