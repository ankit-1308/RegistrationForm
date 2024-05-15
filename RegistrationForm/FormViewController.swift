//
//  FormViewController.swift
//  RegistrationForm
//
//  Created by OLX on 14/05/24.
//


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
        // Do any additional setup after loading the view.
        
        self.title = "User Form"
        if let navigationBar = navigationController?.navigationBar {
                    navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red] // Change UIColor.red to your desired color
                }
        
        view.backgroundColor = UIColor.green
        
        let push = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        push.setTitle("?", for: .normal)
        push.setTitleColor(.red, for: .normal)
        push.addTarget(self, action: #selector(clickPush), for: .touchUpInside)
        view.addSubview(push)
        
    }
    
    @objc func clickPush(){
        
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

        let foodPreference = foodSwitch.isOn ? "Yes" : "No"
        
        let user = User(name: name, phoneNumber: phoneNumber, emailId: emailId, dob: dob, gender: gender, food: foodPreference)
        
        saveUser(user)
        
    }
    

    
    
     func saveUser(_ user: User) {
         
            var users = getUsers()
            users.append(user)
            if let data = try? JSONEncoder().encode(users) {
                UserDefaults.standard.set(data, forKey: "users")
            }
            
            let alert = UIAlertController(title: "Done!!", message: "Your data has been saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                self.clearForm()
            }))
            alert.addAction(UIAlertAction(title: "Show list", style: .default, handler: { _ in
                self.clearForm()
                self.navigationController?.pushViewController(ListViewController(), animated: true)
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
        
    
         func clearForm() {
            nameTextField.text = ""
            phoneNumberTextField.text = ""
            emailTextField.text = ""
            dobDatePicker.date = Date()
            genderSegmentedControl.selectedSegmentIndex = 0
            foodSwitch.isOn = false
        }
    
    

    


}
