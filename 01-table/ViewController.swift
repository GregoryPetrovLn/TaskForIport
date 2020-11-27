////
////  ViewController.swift
////  01-table
////
////  Created by GREGORY PETROV on 26/11/2020.
////
//
//import UIKit
//import SwiftyJSON
//import Alamofire
//
//class ViewController: UITableViewController {
//    var allPosts = [Post]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        tableView.register(TableViewController.self, forCellReuseIdentifier: "Cell")
//
//        parseJSON()
//    }
//
//
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allPosts.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//       //cell.textLabel?.text = allPosts[indexPath.row].body
//        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//         return "Section \(section)"
//     }
//
//    func parseJSON(){
//
//              let url = "https://jsonplaceholder.typicode.com/posts"
//              AF.request(url).responseJSON { (response) in
//                  switch response.result {
//                  case .success(let value):
//
//                      let json = JSON(value)
//                      print(json)
//
//                      for value in json.arrayValue {
//                          let userId = value.dictionaryValue["userId"]!.intValue
//                          let title = value.dictionaryValue["title"]!.stringValue
//                          let body = value.dictionaryValue["body"]!.stringValue
//
//
//
//                          let post = Post(userId: userId, title: title, body: body)
//
//
//
//                          self.allPosts.append(post)
//
//
//                      }
//                      DispatchQueue.main.async {
//                          self.tableView.reloadData()
//                      }
//                  case .failure(let error):
//                      print(error)
//                  }
//
//              }
//
//          }
//
//
//
//}

