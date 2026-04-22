//
//  FilmListView.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-22.
//

import SwiftUI

struct FilmListView: View {
    
    // List of [Film] objects
    @State private var filmsViewModel = FilmsViewModel()
    
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
                List(films) {
                    Text($0.title)
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
    FilmListView()
}
