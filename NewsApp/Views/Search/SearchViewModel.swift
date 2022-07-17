//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
import Moya
import Combine

class SearchViewModel: ObservableObject{
    @Published var searchText: String = ""
    @Published var selectedCategory: String = ""
    let categories = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
    @Published var articles: Articles = []
    @Published var articlePage: Int = 1
    let provider: MoyaProvider<ArticleAPI>
    @Published var isBusy: Bool = false
    @Published var showFilter: Bool = false
    
    @Published var selectedLanguage: FilterItem?
    @Published var selectedCountry: FilterItem?
    
    private var newsSubscription: AnyCancellable?
    private var newsWithFilterSubscription: AnyCancellable?
    
    init(){
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<ArticleAPI>(plugins: [networkLogger])
    }
    
    /// Able to get news by filtering with keywords
    /// - Parameter completion: returns status and message
    func getNewsByKeyword(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        isBusy = true
        newsSubscription = provider.requestPublisher(.searchNews(keywords: searchText, page: 1, pageSize: 10))
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
                        self?.articles = filteredData
                        completion(true, nil)
                    }else{
                        completion(false, response.message ?? "Something went wrong")
                    }
                }
                self?.isBusy = false
                self?.newsSubscription?.cancel()
            })
    }
    
    /// Able to get news with filters
    /// - Parameter completion: returns status and message
    func getNewsByCategory(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        isBusy = true
        newsWithFilterSubscription = provider.requestPublisher(.searchNewsWithFilter(category: selectedCategory, country: selectedCountry?.code ?? "",language: selectedLanguage?.code ?? "", keywords: searchText, page: articlePage, pageSize: 10))
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
                        self?.articles = filteredData
                        completion(true, nil)
                    }else{
                        completion(false, response.message ?? "Something went wrong")
                    }
                }
                self?.isBusy = false
                self?.newsWithFilterSubscription?.cancel()
            })
    }
}
