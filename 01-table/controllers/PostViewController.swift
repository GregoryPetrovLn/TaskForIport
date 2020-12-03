//
//  PostViewController.swift
//  01-table
//
//  Created by GREGORY PETROV on 26/11/2020.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var totalComments: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var text: UITextView!
    
    var post:Post?
    var user:User?
    var commentsAmount = 0
    var vSpinner : UIView?
    let waitingGroup = DispatchGroup()
    let waitingGroup2 = DispatchGroup()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSpinner(onView: self.view)
        waitingGroup.enter()
        parseJSONUser()
        
        waitingGroup2.enter()
        getCommentsAmount()
        
        waitingGroup2.notify(queue: .main) {
            self.removeSpinner()
            self.updateDTO()
        }
    }
    
    
    func updateDTO() {
        label.text = post?.title ?? "Title"
        text.text = post?.body ?? "Text"
        userId.text = String(post?.userIdentifier ??  0)
        totalComments.text = String(commentsAmount)
        name.text = user?.name
        email.text = user?.email
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getCommentsAmount(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: data!)
                
                for comment in comments{
                    print(comment)
                    if comment.postId == self.post?.id{
                        self.commentsAmount += 1
                    }
                }
                self.waitingGroup2.leave()
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    func parseJSONUser(){
        let usersUrl = "https://jsonplaceholder.typicode.com/users/"
        let url = URL(string: "\(usersUrl)\(self.post?.userIdentifier ?? 1)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data!)
                
                let userId = self.post?.userIdentifier
                let name = user.name
                let userName = user.username
                let email = user.email
                self.user = User(id: userId, name: name, username: userName, email: email)
                self.waitingGroup.leave()
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
