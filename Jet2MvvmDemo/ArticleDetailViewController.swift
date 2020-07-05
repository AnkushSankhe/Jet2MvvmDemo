//
//  ViewController.swift
//  Jet2MvvmDemo
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import UIKit
import Network

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var articleViewModels = [ArticleViewModel]()
    var defaultPageNumber : Int = 1
    var isDataAvailable = false
    var monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    var reachability: Reachability!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        tableView.isHidden = true
        
        // MARK: Notification for the reachability
        
        do {
            try reachability = Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
            try reachability.startNotifier()
            } catch {
                let alert = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        
    }
    
    // MARK: Notification observer
    
    @objc func reachabilityChanged(_ note: NSNotification) {
    let reachability = note.object as! Reachability
        if reachability.connection != .unavailable {
            setUp()
            print("Reachable")
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Not Reachable")
            tableView.isHidden = true
        }
        
    }
    
    func setUp()
    {
        fetchData(pageNumber: String(defaultPageNumber))
    }
    
    fileprivate func fetchData(pageNumber : String) {
            Service.shared.fetchCourses(pageNumber: pageNumber)  { (articles, err) in
                if let err = err {
                    print("Failed to fetch courses:", err)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                if articles!.count > 0
                {
                    for item in articles ?? []
                    {
                        self.articleViewModels.append(ArticleViewModel(article: item))
                    }
                    self.isDataAvailable = true
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                else{
                    self.isDataAvailable = false
                }
                
            }
        }
        
        fileprivate func setupNavigationBar() {
            self.navigationItem.title = "Articles"
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 300
            tableView.separatorColor = UIColor.black
        }
}

// MARK: Tableview delegate and datasource

extension ArticleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return articleViewModels.count
       }
       
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellIndentifier", for: indexPath) as! ArticleCell
           
           let articleViewModel = articleViewModels[indexPath.row]
           cell.articleViewModel = articleViewModel
           return cell
       }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let lastElement = articleViewModels.count - 1
           if isDataAvailable && indexPath.row == lastElement {
               defaultPageNumber += 1
               fetchData(pageNumber: String(defaultPageNumber))
           }
       }

}

