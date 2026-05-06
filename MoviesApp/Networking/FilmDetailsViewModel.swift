//
//  FilmDetailsViewModel.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-23.
//

import Foundation
import Observation

@MainActor
@Observable
class FilmDetailsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    
    private let service: FilmService
    
    init(service: FilmService = DefaultFilmService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {

        guard state != .loading else { return }
        state = .loading
        var loadedPeople: [Person] = []

        // Capture service as a local constant so the addTask closure below
        // does not capture self (a @MainActor type). Without this, Swift
        // makes every child task @MainActor-isolated, forcing all network
        // calls to serialise on the main thread. With a local capture the
        // closures are non-isolated and run concurrently on background threads.
        let service = self.service

        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        try await service.fetchPerson(from: personInfoURL)
                    }
                }
                // Collect results as they completed from the task group
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
            
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            self.state = .error("An unexpected error occurred. Please try again later. If the problem persists, please contact support at support@seer99.com")
        }
    }
}

import Playgrounds

#Playground {
    let service = MockFilmService()
    let vm = FilmDetailsViewModel(service: service)
    
    let film = try await service.fetchFilms().first!
    await vm.fetch(for: film)
    
    switch vm.state {
    case .loading: print("Loading")
    case .idle: print("Idle")
    case .loaded(let people):
        for person in people {
            print(person.name)
        }
    case .error(let error): print(error)
    }
    
    
}
