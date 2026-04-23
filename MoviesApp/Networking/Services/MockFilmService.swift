//
//  MockFilmAPIService.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import Foundation

struct MockFilmService: FilmService {
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() async throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        
        let data = try await loadSampleData()
        return data.films
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try await loadSampleData()
        return data.people.first!
    }
}
