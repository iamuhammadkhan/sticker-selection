//
//  StickerManager.swift
//  StickerSelection
//
//  Created by Muhammad Khan on 1/18/22.
//

import UIKit

/// Manager for emojis
final class StickerManager {
    
    /// Array of stickers
    private static var stickers = [UIImage]()
    
    /// Returns array of images for emojis
    static func getStickers() -> [UIImage] {
        let count = getEmojiCount()
        for i in 1...count {
            let image = UIImage(named: "futurama\(i)") ?? UIImage(named: "tibles-logo")!
            stickers.append(image)
        }
        return stickers
    }
    
    /// Will return files count for emojis inside folder
    private static func getEmojiCount() -> Int {
        let resourceURL = Bundle.main.resourceURL!
        let resourcesContent = (try? FileManager.default.contentsOfDirectory(at: resourceURL, includingPropertiesForKeys: nil)) ?? []
        let emojiCount = resourcesContent.filter { $0.lastPathComponent.hasPrefix("futurama") }.count
        return emojiCount
    }
}
