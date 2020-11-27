//
//  PostViewController.swift
//  01-table
//
//  Created by GREGORY PETROV on 26/11/2020.
//

import UIKit
import SwiftyJSON
import Alamofire

class PostViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    
    @IBOutlet weak var totalComments: UILabel!
    
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var text: UITextField!
    
    var post:Post?
    
    var user:User!
    
    
    
    
    var commentsAmount = 0
    
    var userEmail = "email"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let semaphore = DispatchSemaphore(value: 1)
        

        
        DispatchQueue.global().async {
            semaphore.wait()
            self.parseJSONUser()
            sleep(1)
            semaphore.signal()
            self.getCommentsAmount()
        }

        
        
    }
    
    
    func updateDTO() {
        
        
        label.text = post?.title ?? "Title"
        
        text.text = post?.body ?? "Text"
        
        userId.text = String(post?.userId ??  0)
        
        
        totalComments.text = String(commentsAmount)
        
        name.text = user?.name
        
        email.text = user?.email
        
        self.userEmail = user?.email ?? "email"
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func parseJSONUser() {
        let usersUrl = "https://jsonplaceholder.typicode.com/users/"
        
        let url = "\(usersUrl)\(post?.userId ?? 1)"
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                let id = self.post?.userId
                let name = json["name"].stringValue
                let userName = json["username"].stringValue
                let email = json["email"].stringValue
                let phoneNumber = json["phone"].intValue
                
                
                
                let user = User(id: id, name: name, userName: userName, email: email, phoneNumber: phoneNumber)
                
                
                
                self.user = user
                
                self.updateDTO()
                
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    
    func getCommentsAmount(){
        let url = "https://jsonplaceholder.typicode.com/comments"
        
        
        var commentsCounter = 0
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)

                
                for value in json.arrayValue {
                    let email = value.dictionaryValue["email"]!.stringValue
                    
                    
                    if  email == self.userEmail {
                        commentsCounter += 1
                    }
                    
                }
                print(self.userEmail)
                self.commentsAmount = commentsCounter
                
                self.updateDTO()
                
            case .failure(let error):
                print(error)
            }
            
        }
        
        
        
    }
    
    
    
}
