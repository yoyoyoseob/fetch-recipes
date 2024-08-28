//
//  RecipeDetailView.swift
//  fetch-coding-challenge
//
//  Created by Yoseob Lee on 8/26/24.
//

import AVKit
import SwiftUI

struct RecipeDetailView: View {

    @ObservedObject var viewModel: ViewModel

    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: viewModel.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(4)
                } placeholder: {
                    ProgressView()
                }

                Color(.gray.withAlphaComponent(0.4))
                    .frame(height: 1.5)

                LazyVGrid(columns: columns) {
                    ForEach(viewModel.ingredients) { element in
                        Text("\(element.ingredient): \(element.measurement)")
                            .font(.footnote)
                    }
                }
                .padding(.vertical)
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

                    ForEach(Array(viewModel.instructions.enumerated()), id: \.element) { index, step in
                        Text("**\(index + 1).** \(step)")
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(4)
                }

                if let videoURL = viewModel.videoURL {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 240)
                        .padding(.top)
                }
            }
            .padding(.horizontal)
            .navigationTitle(viewModel.name)
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
