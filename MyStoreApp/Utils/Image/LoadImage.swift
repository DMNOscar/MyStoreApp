//
//  LoadImage.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

import UIKit
import Kingfisher

struct ImageLoader {
    
    static func loadImage(image: UIImageView, imageURL: String) {
        if let imageSource = URL(string: imageURL) {
            image.addOverlay()
            let resource = ImageResource(name: imageURL, bundle:  Bundle.main)
            let processor = DownsamplingImageProcessor(size: image.bounds.size)
            image.kf.setImage(
                with: imageSource,
                placeholder:  loadGIF(named: "image_load"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        } else {
            image.image = UIImage(named: "image_placeholder")
            return
        }
    }
    
   
    

    static func loadGIF(named: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: named, ofType: "gif"),
              let data = NSData(contentsOfFile: path),
              let source = CGImageSourceCreateWithData(data, nil) else {
            return nil
        }

        var images = [UIImage]()
        var duration: TimeInterval = 0

        let frameCount = CGImageSourceGetCount(source)
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }

            let frameDuration = gifFrameDuration(source: source, index: i)
            duration += frameDuration
        }

        return UIImage.animatedImage(with: images, duration: duration)
    }

    static  func gifFrameDuration(source: CGImageSource, index: Int) -> TimeInterval {
        let defaultDuration: TimeInterval = 0.1

        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any],
              let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
            return defaultDuration
        }

        return gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? TimeInterval ??
               gifProperties[kCGImagePropertyGIFDelayTime as String] as? TimeInterval ??
               defaultDuration
    }
}
