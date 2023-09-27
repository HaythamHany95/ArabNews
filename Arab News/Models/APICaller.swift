//
//  APICaller.swift
//  Arab News
//
//  Created by Haytham on 23/09/2023.
//

import Foundation

protocol NewsAPIDelegate {
    func didFetchData(news: News?)
    func didFailWithError(error: Error?)
}

class APICaller {
    
    var delegate: NewsAPIDelegate?
    
    let newsUrl = "https://newsapi.org/v2/top-headlines?sources=google-news-sa&apiKey=1f947e49d6534e428bdda6cc3e84d7d6"
    
    func fetchData() {
        guard let url = URL(string: newsUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URLRequest(url: url)) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            print(data)
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                self?.delegate?.didFetchData(news: news)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
