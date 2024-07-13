import SwiftUI

public struct TipBox: View {
    let tip: TipInfo // TipInfomation
    let isShowAnimationEnabled: Bool // Show animation flag(true: show animation, false: not show animation)
    @State var isVisible: Bool = false // TipBox visibility flag(true: visible, false: invisible)

    let inspection = Inspection<Self>() // For ViewInspector Tests

    /// initialize
    /// - Parameters:
    ///   - tip: TipInfomation
    ///   - isShowAnimationEnabled: Show animation flag(default: false)
    public init(_ tip: TipInfo, isShowAnimationEnabled: Bool = true) {
        self.tip = tip
        self.isShowAnimationEnabled = isShowAnimationEnabled
    }

    public var body: some View {
        VStack {
            if isVisible {
                HStack {
                    // Icon
                    Image(systemName: tip.image)
                        .foregroundColor(.blue)
                        .padding(.leading, 10)

                    // Title and Message
                    VStack(alignment: .leading) {
                        Text(tip.title)
                            .font(.headline)
                            .foregroundColor(.black)

                        Text(tip.message)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 5)

                    Spacer()

                    // Close button
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    })
                }
                .padding()
                .background(Color(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0))
                .cornerRadius(10)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
            }
        }
        .onAppear {
            if isShowAnimationEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        isVisible = true
                    }
                }
            } else {
                isVisible = true
            }
        }
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output) // For ViewInspector Tests
        })
    }
}

#Preview {
    struct SampleTip: TipInfo {
        var title: String = "Title"
        var message: String = "Message"
        var image: String = "lightbulb"
    }

    return VStack {
        TipBox(SampleTip(), isShowAnimationEnabled: true)
        TipBox(SampleTip(), isShowAnimationEnabled: false)
    }
}
