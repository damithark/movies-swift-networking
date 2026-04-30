//
//  FilmDetailView.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-27.
//

import SwiftUI

struct FilmDetailsView: View {
    
    let film: Film
    
    @State private var viewModel = FilmDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Text(film.title)
                    .font(.title)
                    .fontWeight(.bold)
            }
            VStack(alignment: .leading) {
                FilmBannerImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .clipped()
                Divider()
                Text("Characters")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                switch viewModel.state {
                case .idle: Text("No details")
                case .loading:
                    ProgressView {
                        Text("Loading people...")
                    }
                case .loaded(let people):
                    ForEach(people) { person in
                        Text(person.name)
                    }
                case .error(let error):
                    Text(error.localizedCapitalized)
                }
            }
            .padding(.horizontal)
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailsView(film: Film.example)
}
