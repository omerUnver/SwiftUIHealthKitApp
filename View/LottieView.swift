//
//  LottieView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import SwiftUI
import Lottie
struct LottieView: UIViewRepresentable {
    var name = ""
    var loopMode : LottieLoopMode = .playOnce
    static let duration : Double = 1.5
    @Binding var isAnimating: Bool
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name, bundle: Bundle.main)
        animationView.loopMode = loopMode
        animationView.animationSpeed = LottieView.duration
        animationView.contentMode = .scaleAspectFit
        animationView.play(completion: { _ in
                    isAnimating = false
                })
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
    
    
}

struct GeriLottieView : UIViewRepresentable {
    
    var name = ""
    var loopMode : LottieLoopMode = .playOnce
    static let duration : Double = 1.5
    @Binding var notAnimating: Bool
    func makeUIView(context: UIViewRepresentableContext<GeriLottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name, bundle: Bundle.main)
        animationView.loopMode = loopMode
        animationView.animationSpeed = GeriLottieView.duration
        animationView.contentMode = .scaleAspectFit
        animationView.play(completion: { _ in
            notAnimating = false
                })
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        ])
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<GeriLottieView>) {
        
    }
}
