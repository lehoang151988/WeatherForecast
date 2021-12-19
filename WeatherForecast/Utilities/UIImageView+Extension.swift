//
//  UIImageView+Extension.swift
//  WeatherForecast
//
//  Created by Hoang Le on 19/12/2021.
//

import Foundation
import UIKit

extension UIImageView {
    public func load(from url: URL?, animated: Bool = true) {
        guard OperationQueue.current == .main else {
            OperationQueue.main.addOperation { self.load(from: url) }
            return
        }
        
        image = nil
        guard let url = url else { return }
        
        ImageFetcher.shared.load(from: url, for: self) { [weak self] result in
            self?.image = result.image
            if animated && result.method == .fetch {
                self?.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self?.alpha = 1
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self?.alpha = 1
                }, completion: { (_) in
                    self?.layer.removeAllAnimations()
                })
            }
        }
    }
}

public class ImageFetcher {
    public static let shared = ImageFetcher()
    
    private let cacheURL: URL? = {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("ImageFetcher", isDirectory: true) else { return nil }
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            return url
        } catch { return nil }
    }()
    private let fetchingQueue = OperationQueue(maxConcurrentOperationCount: 30) // Experiment with count to achieve optimal performance on simultaneous image downloads
    private let cachingQueue = OperationQueue(maxConcurrentOperationCount: 1) // In rare cases the same image might be requested from different parts of the program in the same time and be downloaded twice. To avoid overlapping cached file simultaneously from more than one finished download we need to save one cached image at a time.
    private let memoryCacheQueue = OperationQueue(maxConcurrentOperationCount: 1)
    
    
    private struct LoadedImage { weak var image: UIImage? }
    private var loadedImages = [String : LoadedImage]()
    private func dropReleasedImages() {
        guard OperationQueue.current == memoryCacheQueue else {
            memoryCacheQueue.addOperation { self.dropReleasedImages() }
            return
        }
        loadedImages = loadedImages.filter { $0.value.image != nil }
    }
    
    
    public struct LoadingImageResult {
        public enum Method { case instant, cache, fetch, fail }
        let image: UIImage?
        let method: Method
    }
    
    
    public func load(from url: URL, processing: @escaping (UIImage) -> UIImage = { $0 }, completion: @escaping (LoadingImageResult) -> ()) {
        let cachedImageName = url.absoluteString.data(using: .utf8)?.base64EncodedString() ?? url.absoluteString
        let cachedImageURL = cacheURL?.appendingPathComponent(cachedImageName)
        
        dropReleasedImages()
        
        var alreadyLoadedImage: UIImage?
        memoryCacheQueue.addOperation {
            alreadyLoadedImage = self.loadedImages[cachedImageName]?.image
        }
        memoryCacheQueue.waitUntilAllOperationsAreFinished()
        
        if // Already loaded somewhere else
            let image = alreadyLoadedImage
        {
            let processedImage = processing(image)
            completion(LoadingImageResult(image: processedImage, method: .instant))
            return
        }
        
        fetchingQueue.addOperation { [weak self] in
            if // Cached before
                let cachedImageURL = cachedImageURL,
                let data = try? Data(contentsOf: cachedImageURL),
                let image = UIImage(data: data)
            {
                self?.memoryCacheQueue.addOperation {
                    self?.loadedImages[cachedImageName] = LoadedImage(image: image)
                }
                let processedImage = processing(image)
                OperationQueue.main.addOperation { completion(LoadingImageResult(image: processedImage, method: .cache)) }
            }
            else if // Needs to be downloaded and cached
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            {
                if let cachedImageURL = cachedImageURL {
                    self?.cachingQueue.addOperation { try? data.write(to: cachedImageURL) }
                }
                self?.memoryCacheQueue.addOperation {
                    self?.loadedImages[cachedImageName] = LoadedImage(image: image)
                }
                let processedImage = processing(image)
                OperationQueue.main.addOperation { completion(LoadingImageResult(image: processedImage, method: .fetch)) }
            }
            else { // Loading failed
                OperationQueue.main.addOperation { completion(LoadingImageResult(image: nil, method: .fail)) }
            }
        }
    }
    
    private var receiversAndCompletableOperationIDs = [Int : UUID]()
    
    /// Previous completion block is cancelled if load is requested again for the same receiver (usually UIImageView, but can be anything (including String or UUID) retriving one image at a time where overlapping fetches are not allowed). ImageFetcher does NOT keep strong reference to the receiver but released receiver doesn't cancel completion.
    public func load(from url: URL, processing: @escaping (UIImage) -> UIImage = { $0 }, for receiver: AnyHashable, completion: @escaping (LoadingImageResult) -> ()) {
        guard OperationQueue.current == .main else {
            OperationQueue.main.addOperation { self.load(from: url, for: receiver, completion: completion) }
            return
        }
        let operationID = UUID()
        let receiverHash = receiver.hashValue
        receiversAndCompletableOperationIDs[receiverHash] = operationID
        load(from: url, processing: processing) { image in
            guard self.receiversAndCompletableOperationIDs[receiverHash] == operationID else { return }
            completion(image)
            self.receiversAndCompletableOperationIDs.removeValue(forKey: receiverHash)
        }
    }
}


public extension OperationQueue {
    convenience init(maxConcurrentOperationCount: Int) {
        self.init()
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
}
