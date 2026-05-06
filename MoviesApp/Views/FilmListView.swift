//
//  FilmListView.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import SwiftUI

struct FilmListView: View {
    
    // List of [Film] objects
    @State var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No films")
            case .loading:
                ProgressView {
                    Text("Loading films list...")
                }
            case .loaded(let films) :
                List(films) { selectedFilm in
                    NavigationLink(value: selectedFilm) {
                        HStack {
                            FilmBannerImageView(urlPath: selectedFilm.image)
                                .frame(width: 80, height: 150)
                                .scaledToFit()
                                .padding(.horizontal)
                                .cornerRadius(10)
                            Text(selectedFilm.title)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailsView(film: film)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
        
    }
}

#Preview {
    
    @State @Previewable var vm = FilmsViewModel(service: MockFilmService())
    FilmListView(filmsViewModel: vm)
}
