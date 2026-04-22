//
//  MovieAPIService.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import Foundation

protocol FilmAPIService {
    func fetchFilms() async throws -> [Film]
}
