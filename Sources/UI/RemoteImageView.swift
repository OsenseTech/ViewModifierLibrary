//
//  RemoteImageView.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/6.
//  https://stackoverflow.com/a/68999902/3295047

import SwiftUI

public struct RemoteImageView<Placeholder: View, ConfiguredImage: View>: View {
    private let url: URL
    private let image: (Image) -> ConfiguredImage
    private let placeholder: () -> Placeholder
    
    @ObservedObject var imageLoader: ImageLoaderService
    @State var imageData: UIImage?
    
    public init(
        url: URL,
        @ViewBuilder image: @escaping (Image) -> ConfiguredImage,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.image = image
        self.placeholder = placeholder
        self.imageLoader = ImageLoaderService(url: url)
    }
    
    @ViewBuilder private var imageContent: some View {
        if let data = imageData {
            image(Image(uiImage: data))
        } else {
            placeholder()
        }
    }
    
    public var body: some View {
        imageContent
            .onReceive(imageLoader.$image) { imageData in
                self.imageData = imageData
            }
    }
}
