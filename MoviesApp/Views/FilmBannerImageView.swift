//
//  FilmBannerImageView.swift
//  MoviesApp
//
//  Created by Damitha Raveendra on 2026-04-28.
//

import SwiftUI

struct FilmBannerImageView: View {
    
    let urlPath: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlPath)) {
            phase in
                switch phase {
                case .empty:
                    Color(white: 0.8)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .containerRelativeFrame(.horizontal)
                case .failure(_):
                    Text("Could not load image")
                @unknown default:
                    fatalError()
                }
        }
    }
}

#Preview("Banner Image") {
    FilmBannerImageView(urlPath: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg")
        .frame(height: 300)
}

#Preview("Poster Image") {
    FilmBannerImageView(urlPath: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
        .frame(height: 150)
}
