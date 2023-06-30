//
//  LocalDataProvider.swift
//  RickAndMorty
//
//  Created by Kader Oral on 29.06.2023.
//

import Foundation

class LocalDataProvider {
    static let shared = LocalDataProvider()
    private var seriesData: [Series]?
    
    func getSeriesData() -> [Series]? {
        return seriesData
    }
    
    func setSeriesData(_ data: [Series]) {
        seriesData = data
    }
}
