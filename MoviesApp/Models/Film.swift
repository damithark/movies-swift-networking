//
//  Film.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import Foundation

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    
    let releaseYear: String
    let duration: String
    let score: String
    let image: String
    let bannerImage: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, director, image, producer, people
        
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
    
    //MARK: Preview
    static var example: Film {
        MockFilmService().fetchFilm()
    }
}

import Playgrounds

#Playground {
    
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        print(try JSONDecoder().decode([Film].self, from: data))
    } catch {
        print(error)
    }
    
}
