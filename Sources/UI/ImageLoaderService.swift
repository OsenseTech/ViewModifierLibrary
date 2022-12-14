//
//  ImageLoaderService.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/6.
//

import SwiftUI

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()
    
    convenience init(url: URL) {
        self.init()
        loadImage(for: url)
    }
    
    func loadImage(for url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
