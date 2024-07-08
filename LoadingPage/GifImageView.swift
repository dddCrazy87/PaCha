import SwiftUI
import UIKit
import ImageIO

class GifImageLoader: UIView {
    private let imageView = UIImageView()
    private var timer: CADisplayLink?
    private var frames: [UIImage] = []
    private var frameDelays: [Double] = []
    private var totalDuration: Double = 0
    private var currentTime: Double = 0
    private var currentFrame = 0
    
    init(name: String) {
        super.init(frame: .zero)
        loadGif(name: name)
        setupImageView()
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadGif(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let source = CGImageSourceCreateWithData(data as CFData, nil) else { return }
        
        let frameCount = CGImageSourceGetCount(source)
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let frame = UIImage(cgImage: cgImage)
                frames.append(frame)
                
                var delay = 0.1
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                   let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] {
                    delay = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double ?? 0.1
                    delay = delay < 0.011 ? 0.1 : delay
                }
                frameDelays.append(delay)
                totalDuration += delay
            }
        }
    }
    
    private func setupImageView() {
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    private func startAnimation() {
        timer = CADisplayLink(target: self, selector: #selector(updateFrame))
        timer?.add(to: .main, forMode: .common)
    }
    
    @objc private func updateFrame() {
        currentTime += 1 / 60.0
        if currentTime >= totalDuration {
            currentTime = 0
        }
        
        var frameTime: Double = 0
        for (index, delay) in frameDelays.enumerated() {
            frameTime += delay
            if currentTime < frameTime {
                if currentFrame != index {
                    imageView.image = frames[index]
                    currentFrame = index
                }
                break
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

struct GifImageView: UIViewRepresentable {
    let name: String
    
    func makeUIView(context: Context) -> GifImageLoader {
        GifImageLoader(name: name)
    }
    
    func updateUIView(_ uiView: GifImageLoader, context: Context) {}
}
