//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
import Moya
import Combine

class HomeViewModel: ObservableObject{
    @Published var searchText: String = ""
    @Published var latestArticles: Articles = []
    @Published var categoryArticles: Articles = []
    @Published var selectedCategory: String = "Business"
    let categories = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
    let provider: MoyaProvider<ArticleAPI>
    @Published var latestNewsIsBusy: Bool = false
    @Published var newsCategoryIsBusy: Bool = false
    @Published var categoryArticlePage: Int = 1
    
    private var newsSubscription: AnyCancellable?
    private var newsWithFilterSubscription: AnyCancellable?
    
    init(){
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<ArticleAPI>(plugins: [networkLogger])
    }
    
    func getLatestNews(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        
        newsSubscription = provider.requestPublisher(.topHeadline(country: "US", page: 1, pageSize: 10))
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap{ element -> Data in
                return element.data
            }
            .decode(type: NAResponse<Articles>.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { receiveCompletion in
                guard case let .failure(error) = receiveCompletion else { return }
                completion(false, "We're having trouble connecting to the server, please try again")
                print("Error \(error)")
            }, receiveValue: {[weak self] response in
                switch response.status {
                case .error:
                    completion(false, response.message ?? "Something went wrong")
                case .ok:
                    if let data = response.articles {
                        let filteredData = data.filter { article in
                            guard (article.urlToImage != nil) else {
                                return false
                            }
                            return true
                        }
                        self?.latestArticles += filteredData
                        completion(true, nil)
                    }else{
                        completion(false, response.message ?? "Something went wrong")
                    }
                }
                self?.newsSubscription?.cancel()
            })
    }
    
    func getLatestNewsByCategory(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        
        newsWithFilterSubscription = provider.requestPublisher(.topHeadlineWithFilter(category: selectedCategory, country: "US", language: "en", page: categoryArticlePage, pageSize: 10))
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .tryMap{ element -> Data in
                return element.data
            }
            .decode(type: NAResponse<Articles>.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { receiveCompletion in
                guard case let .failure(error) = receiveCompletion else { return }
                completion(false, "We're having trouble connecting to the server, please try again")
                print("Error \(error)")
            }, receiveValue: {[weak self] response in
                switch response.status {
                case .error:
                    completion(false, response.message ?? "Something went wrong")
                case .ok:
                    if let data = response.articles {
                        let filteredData = data.filter { article in
                            guard (article.urlToImage != nil) else {
                                return false
                            }
                            return true
                        }
                        self?.categoryArticles += filteredData
                        completion(true, nil)
                    }else{
                        completion(false, response.message ?? "Something went wrong")
                    }
                }
                self?.newsWithFilterSubscription?.cancel()
            })
    }
}
