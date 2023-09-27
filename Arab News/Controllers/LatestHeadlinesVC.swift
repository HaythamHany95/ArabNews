//
//  ViewController.swift
//  Arab News
//
//  Created by Haytham on 23/09/2023.
//

import UIKit

class LatestHeadlinesVC: UIViewController {
    
    var newsApi = APICaller()
    var articles: [Article] = []
    
    @IBOutlet weak var headlinesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headlinesTableView.dataSource = self
        headlinesTableView.delegate = self
        newsApi.delegate = self
        
        newsApi.fetchData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? NewsDetailsVC
        let selectedRow = headlinesTableView.indexPathForSelectedRow?.row
    
        vc?.newsUrl = articles[selectedRow ?? 0].url
    }
    
}

extension LatestHeadlinesVC: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath)
        cell.textLabel?.text =  articles[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}

extension LatestHeadlinesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension LatestHeadlinesVC: NewsAPIDelegate {
    func didFetchData(news: News?) {
        DispatchQueue.main.async {
            self.articles = news?.articles ?? []
            self.headlinesTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error?) {
        print(error ?? "")
    }
    
}
