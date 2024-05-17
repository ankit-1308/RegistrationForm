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
        
        tableView.backgroundColor = UIColor.yellow
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
    
    let name = UILabel()
    let phoneNumber = UILabel()
    let email = UILabel()
    let dob = UILabel()
    let gender = UILabel()
    let food = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(name)
        addSubview(phoneNumber)
        addSubview(email)
        addSubview(dob)
        addSubview(gender)
        addSubview(food)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        dob.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        food.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            phoneNumber.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            phoneNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            phoneNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 10),
            email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            dob.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            dob.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dob.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            gender.topAnchor.constraint(equalTo: dob.bottomAnchor, constant: 10),
            gender.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gender.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            food.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 10),
            food.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            food.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            food.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
        ])
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
        cell.backgroundColor = UIColor.brown
        cell.layer.cornerRadius = 2.0
       
        cell.layer.borderWidth = 2.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return UITableView.automaticDimension
        
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200 // You can set an estimated row height here for performance improvements
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
