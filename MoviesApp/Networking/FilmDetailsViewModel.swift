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

        do {
            // Fetch each person sequentially. Because fetchPerson(from:) is a
            // non-isolated async function, every `await` here hops the work
            // OFF the main actor onto a background thread for the duration of
            // the network request, then hops back to update state. This keeps
            // the main thread free and the UI responsive throughout.
            var loadedPeople: [Person] = []
            for personURL in film.people {
                let person = try await service.fetchPerson(from: personURL)
                loadedPeople.append(person)
            }
            state = .loaded(loadedPeople)

        } catch let error as APIError {
            state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            state = .error("An unexpected error occurred. Please try again later.")
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
