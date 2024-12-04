// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct FlipView<FrontView: View, BackView: View>: View {
    
    let frontView: FrontView
    let backView: BackView
    
    @State var showBack: Bool = false
    
    var flipAction: ((Bool) -> Void)?
    
    public init(@ViewBuilder front: () -> FrontView, @ViewBuilder back: () -> BackView) {
        frontView = front()
        backView = back()
    }
    
    public func onFlipChange(_ action: @escaping ((Bool) -> Void)) -> Self {
        var copy = self
        copy.flipAction = action
        return copy
    }
    
    public var body: some View {
        ZStack() {
            frontView
                .modifier(FlipOpacity(percentage: showBack ? 0 : 1))
                .rotation3DEffect(Angle.degrees(showBack ? 180 : 360), axis: (0,1,0))
            backView
                .modifier(FlipOpacity(percentage: showBack ? 1 : 0))
                .rotation3DEffect(Angle.degrees(showBack ? 0 : 180), axis: (0,1,0))
        }
        .onTapGesture {
            withAnimation {
                self.showBack.toggle()
            }
        }
        .onChange(of: showBack) { value in
            flipAction?(value)
        }
    }
}

private struct FlipOpacity: AnimatableModifier {
    var percentage: CGFloat = 0
    
    var animatableData: CGFloat {
        percentage
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(Double(percentage.rounded()))
    }
}

private struct FlipViewPreview: View {
    var body: some View {
        FlipView {
            ZStack {
                Color.blue
                Text("Front")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        } back: {
            ZStack {
                Color.red
                Text("Back")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    FlipViewPreview()
        .preferredColorScheme(.dark)
}
