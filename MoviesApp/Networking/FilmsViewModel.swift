//
//  FimlsViewModel.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import Foundation
import Observation

@MainActor
@Observable
class FilmsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    private let service: FilmService
    
    init(service: FilmService = DefaultFilmService()) {
        self.service = service
    }
    
    func fetch() async {
        
        guard state == .idle else { return }
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            self.state = .error("An unexpected error occurred. Please try again later. If the problem persists, please contact support at support@seer99.com")
        }
    }
    
}
