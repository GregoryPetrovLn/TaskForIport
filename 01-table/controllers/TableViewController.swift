//
//  TableViewController.swift
//  01-table
//
//  Created by GREGORY PETROV on 26/11/2020.
//
import Foundation
import UIKit


class TableViewController: UITableViewController {
    var allPosts = [Post]()
    var selectedPost: Post?
    var vSpinner : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSpinner(onView: self.view)
        parseJSON()
    }
    
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allPosts[indexPath.row].title
        cell.detailTextLabel?.text = String(allPosts[indexPath.row].id )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts"
    }
    
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        let post = allPosts[indexPath.row]
        selectedPost = post
        performSegue(withIdentifier: "ShowDetails", sender: nil)
        
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails"{
            if  let postDetailTVC = segue.destination as? PostViewController{
                postDetailTVC.post = selectedPost
            }
        }
    }
    
    
    func parseJSON(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data!)
                
                for p in posts{
                    let id = p.id
                    let body = p.body
                    let title = p.title
                    let userId = p.userIdentifier
                    let post = Post(id: id, userId: userId, title: title, body: body)
                    self.allPosts.append(post)
                    
                    self.removeSpinner()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
     
}
