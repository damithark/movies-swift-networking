//
//  FilmDetailsViewModel.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-23.
//

import Foundation
import Observation

class FilmDetailsViewModel {
    
    var people: [Person] = []
    
    let service: FilmService
    
    init(service: FilmService = DefaultFilmService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
//        do {
//            try await withThrowingTaskGroup(of: Person.self) { group in
//                for personInfoURL in film.people {
//                    group.addTask {
//                        try await service.fetchPerson(from: personInfoURL)
//                    }
//                }
//            }
//        } catch {
//            
//        }
    }
}
