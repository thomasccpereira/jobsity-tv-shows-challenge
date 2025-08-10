import SwiftUI

struct ShimmerView: ViewModifier {
   @Environment(\.accessibilityReduceMotion) private var reduceMotion
   let active: Bool
   let cornerRadius: CGFloat
   let blendMode: BlendMode
   
   func body(content: Content) -> some View {
      content
         .overlay(alignment: .center) {
            if active {
               let base  = Color(.systemGray5)
               let shine = Color.white.opacity(0.6)
               
               LinearGradient(
                  colors: [base, shine, base],
                  startPoint: .leading,
                  endPoint: .trailing
               )
               .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
               .blendMode(blendMode)
               .phaseAnimator([-1.2, 1.2]) { view, phase in
                  view.offset(x: phase * 240)
               } animation: { _ in
                  reduceMotion
                  ? .default
                  : .linear(duration: 1.1).repeatForever(autoreverses: false)
               }
               .mask { content }
               .allowsHitTesting(false)
            }
         }
   }
}

extension View {
   func shimmer(active: Bool,
                cornerRadius: CGFloat = 8,
                blendMode: BlendMode = .plusLighter) -> some View {
      self
         .redacted(reason: active ? .placeholder : [])
         .modifier(ShimmerView(active: active,
                               cornerRadius: cornerRadius,
                               blendMode: blendMode))
   }
}
