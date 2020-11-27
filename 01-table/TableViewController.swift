//
//  TableViewController.swift
//  01-table
//
//  Created by GREGORY PETROV on 26/11/2020.
//
import Foundation

import UIKit
import SwiftyJSON
import Alamofire

class TableViewController: UITableViewController {
    var allPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = allPosts[indexPath.row].title
        cell.detailTextLabel?.text = String(allPosts[indexPath.row].id ??  0)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts"
    }
    
    
    var selectedPost: Post!
    
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        
        let post = allPosts[indexPath.row]
        
        selectedPost = post
        
        performSegue(withIdentifier: "ShowDetails", sender: nil)
        
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails"{
            let postDetailTVC = segue.destination as! PostViewController
            postDetailTVC.post = selectedPost
            
        }
        
    }
    
    
    
    
    
    
    
    func parseJSON(){
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                for value in json.arrayValue {
                    let id = value.dictionaryValue["id"]!.intValue
                    let userId = value.dictionaryValue["userId"]!.intValue
                    let title = value.dictionaryValue["title"]!.stringValue
                    let body = value.dictionaryValue["body"]!.stringValue
                    
                    
                    
                    let post = Post(id:id, userId: userId, title: title, body: body)
                    
                    
                    
                    self.allPosts.append(post)
                    
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    
    
    
    
    
    
}



