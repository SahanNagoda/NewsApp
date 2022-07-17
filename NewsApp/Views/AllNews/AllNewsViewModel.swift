//
//  AllNewsViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import Foundation
import Moya
import Combine

class AllNewsViewModel: ObservableObject{
    @Published var articles: Articles = []
    @Published var articlePage: Int = 1
    @Published var selectedLanguage: FilterItem?
    @Published var selectedCountry: FilterItem?
    @Published var isBusy: Bool = false
    @Published var showFilter: Bool = false
    var totalArticleCount: Int = 0
    let provider: MoyaProvider<ArticleAPI>
    private var newsWithFilterSubscription: AnyCancellable?
    
    init(){
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        provider = MoyaProvider<ArticleAPI>(plugins: [networkLogger])
    }
    
    /// Able to get news with filters
    /// - Parameter completion: returns status and message
    func getLatestNewsWithFilters(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        newsWithFilterSubscription = provider.requestPublisher(.topHeadlineWithFilter(category: "", country: selectedCountry?.code ?? "", language: selectedLanguage?.code ?? "en" , page: articlePage, pageSize: 10))
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
                        self?.articles += filteredData
                        self?.totalArticleCount = response.totalResults ?? 0
                        completion(true, nil)
                    }else{
                        completion(false, response.message ?? "Something went wrong")
                    }
                }
                self?.newsWithFilterSubscription?.cancel()
            })
    }
}
