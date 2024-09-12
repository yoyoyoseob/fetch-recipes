//
//  RecipeDetailView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import AVKit
import SwiftUI

struct RecipeDetailView: View {

    @State private var showingAlert = false
    @ObservedObject var viewModel: ViewModel

    private let rows: [GridItem] = [
        .init(.flexible(), spacing: 4, alignment: .leading),
        .init(.flexible(), spacing: 4,alignment: .leading),
        .init(.flexible(), spacing: 4,alignment: .leading),
        .init(.flexible(), spacing: 4,alignment: .leading),
        .init(.flexible(), spacing: 4,alignment: .leading)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let result):
                    AsyncImage(url: result.imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(4)
                    } placeholder: {
                        ProgressView()
                    }

                    Color(.gray.withAlphaComponent(0.4))
                        .frame(height: 1.5)

                    Group {
                        if !result.ingredients.isEmpty {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: rows, spacing: 12) {
                                    ForEach(result.ingredients) { element in
                                        Text("\(element.ingredient.capitalized): \(element.measurement)")
                                            .font(.footnote)
                                    }
                                }
                            }
                        } else {
                            Text("<Ingredients>")
                        }
                    }
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.gray, lineWidth: 1)
                    }

                    Color(.gray.withAlphaComponent(0.4))
                        .frame(height: 1.5)

                    VStack(alignment: .leading) {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.top, 2)

                        ForEach(Array(result.instructions.enumerated()), id: \.element) { index, step in
                            Text("**\(index + 1).** \(step)")
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(4)
                    }

                    if let videoURL = result.videoURL {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(height: 240)
                            .padding(.top)
                    }
                case .error(let error):
                    Text("Oops, something went wrong")
                        .onAppear { showingAlert = true }
                        .alert(error.localizedDescription, isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {}
                        }
                }
            }
            .padding(.horizontal)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadDetails()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(viewModel: .init(recipe: .init(id: "1",
                                                        name: "Chocolate Buttercream Muffin",
                                                        thumbnailURLString: ""),
                                          networkService: .init()))
    }
}
