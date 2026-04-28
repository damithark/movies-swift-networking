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
        VStack {
            Text(film.title)
        }
    }
}

#Preview {
    FilmDetailsView(film: Film.example)
}
