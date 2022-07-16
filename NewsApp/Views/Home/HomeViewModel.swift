//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var searchText: String = ""
    let categories = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
}
