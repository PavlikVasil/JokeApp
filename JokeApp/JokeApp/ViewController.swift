//
//  ViewController.swift
//  JokeApp
//
//  Created by Павел on 19.01.2021.
//
import Alamofire
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        inputField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadButton.layer.cornerRadius = 0.5 * loadButton.bounds.size.width
    }
    
    var count = 0
    
    var items: [StoreItem?] = []

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var loadButton: UIButton!
    
    
    @IBAction func load(_ sender: Any) {
        
        self.count = Int(inputField.text ?? "") ?? 0
        tableView.reloadData()
        loadData()
        inputField.resignFirstResponder()
    }
    

    func loadData(){
       let request = AF.request("http://api.icndb.com/jokes/random/\(count)")
        
        
        request.validate().responseDecodable(of: StoreItems.self){(response) in
            
            guard let jokes = response.value else {return}
            self.items = jokes.value
            self.tableView.reloadData()
        }
    }


    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           
           return
        }
      
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
    }
}


extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let item = items[indexPath.row]
        
        cell.jokeLabel?.text = item?.joke
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }   
}
