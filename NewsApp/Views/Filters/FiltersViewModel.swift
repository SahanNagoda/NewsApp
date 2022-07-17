//
//  FiltersViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

class FiltersViewModel: ObservableObject{
    var countries: [FilterItem] = []
    @Published var selectedCountry: FilterItem?
    var language: [FilterItem] = []
    @Published var selectedLanguage: FilterItem?
    
    init(){
        countries = [
            FilterItem(title: "Australia", code: "au"),
            FilterItem(title: "Canada", code: "ca"),
            FilterItem(title: "France", code: "fr"),
            FilterItem(title: "India", code: "in"),
            FilterItem(title: "Japan", code: "jp"),
            FilterItem(title: "South Korea", code: "kr"),
            FilterItem(title: "New Zealand", code: "nz"),
            FilterItem(title: "Russia", code: "ru"),
            FilterItem(title: "Singapore", code: "sg"),
            FilterItem(title: "United States", code: "us")
        ]
        language = [
            FilterItem(title: "English", code: "en"),
            FilterItem(title: "Arabic", code: "ar"),
            FilterItem(title: "French", code: "fr"),
            FilterItem(title: "Russian", code: "ru"),
            FilterItem(title: "Lithuanian", code: "it"),
            FilterItem(title: "Swedish", code: "sv"),
            FilterItem(title: "Dutch", code: "nl")
        ]
    }
}

