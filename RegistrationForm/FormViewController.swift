////
////  FormViewController.swift
////  RegistrationForm
////
////  Created by OLX on 14/05/24.

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var foodSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "User Form"
        view.backgroundColor = UIColor.green

        let push = UIButton(frame: CGRect(x: 280, y: 50, width: 150, height: 50))
        push.setTitle("?", for: .normal)
        push.setTitleColor(.red, for: .normal)
        push.addTarget(self, action: #selector(clickPush), for: .touchUpInside)
        
//        let push1 = UIButton(type: .custom)
//        NSLayoutConstraint.activate([
//            push1.widthAnchor.constraint(equalToConstant: 150),
//            push1.heightAnchor.constraint(equalToConstant: 50),
//            push1.leadingAnchor.constraint(equalTo: push.trailingAnchor, constant: 8.0)
//        ])
        
        
        
        view.addSubview(push)
        
    }
    
    @objc func clickPush() {
        let listVC = ListViewController()
        navigationController?.pushViewController(listVC, animated: true)
        }
    

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let emailId = emailTextField.text, !emailId.isEmpty
        else {
            
            let alert = UIAlertController(title: "Error", message: "All fields are required.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let dob = dateFormatter.string(from: dobDatePicker.date)

        let genderIndex = genderSegmentedControl.selectedSegmentIndex
        let gender = genderSegmentedControl.titleForSegment(at: genderIndex) ?? ""

        let foodPreference = foodSwitch.isOn ? "Veg" : "Non-Veg"

        let user = User(name: name,
                        phoneNumber: phoneNumber,
                        emailId: emailId,
                        dob: dob,
                        gender:gender,
                        food: foodPreference)

        saveUser(user)
    }
    
     func saveUser(_ user: User) {
        var users = getUsers()
        users.append(user)
         guard let data = try? JSONEncoder().encode(users) else {
             print("Failed to encode data")
             return
         }
         
         UserDefaults.standard.set(data, forKey: "users")
        let alert = UIAlertController(title: "Done!!", message: "Your data has been saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            self.clearForm()
        }))
         
        alert.addAction(UIAlertAction(title: "Show list", style: .default, handler: { _ in
            self.clearForm()
            let listVC = ListViewController()
            self.navigationController?.pushViewController(listVC, animated: true)
        }))
         
        self.present(alert, animated: true, completion: nil)
    }
    
 
     func getUsers() -> [User] {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }
    
    private func clearForm() {
        nameTextField.text = ""
        phoneNumberTextField.text = ""
        emailTextField.text = ""
        dobDatePicker.date = Date()
        genderSegmentedControl.selectedSegmentIndex = 0
        foodSwitch.isOn = false
    }
}

