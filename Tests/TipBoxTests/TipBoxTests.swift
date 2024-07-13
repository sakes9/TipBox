import SwiftUI
@testable import TipBox
import ViewInspector
import XCTest

final class TipBoxTests: XCTestCase {
    /// Test case for TipBox Element
    func testTipBoxElement() throws {
        struct TestTip: TipInfo {
            var title: String = "Test Title"
            var message: String = "Test Message"
            var image: String = "lightbulb"
        }
        let tip = TestTip()
        let sut = TipBox(tip, isShowAnimationEnabled: false)

        let exp = sut.inspection.inspect { view in
            XCTAssertTrue(try view.actualView().isVisible)

            // Validating the title
            let title = try view.find(text: tip.title).string()
            XCTAssertEqual(title, tip.title, "Title should be set to 'Test Title'")

            // Validating the message
            let message = try view.find(text: tip.message).string()
            XCTAssertEqual(message, tip.message, "Message should be set to 'Test Message'")

            // Validating the image
            let image = try view.find(ViewType.Image.self).actualImage().name()
            XCTAssertEqual(image, tip.image, "Image should be set to 'lightbulb'")
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }

    /// Test case for TipBox Show Animation Enabled
    func testTipBoxShowAnimationEnabled() throws {
        struct TestTip: TipInfo {
            var title: String = "Test Title"
            var message: String = "Test Message"
            var image: String = "lightbulb"
        }
        let tip = TestTip()
        let sut = TipBox(tip, isShowAnimationEnabled: true)

        let exp = expectation(description: "Waiting for animation")
        sut.inspection.inspect { view in
            // It is delayed to run after the animation is displayed.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                do {
                    XCTAssertTrue(try view.actualView().isVisible)
                    exp.fulfill()
                } catch {
                    // It is impossible to enter a catch block.
                }
            }
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 2)
    }

    /// Test case for TipBox Show Animation Disabled
    func testTipBoxShowAnimationDisabled() throws {
        struct TestTip: TipInfo {
            var title: String = "Test Title"
            var message: String = "Test Message"
            var image: String = "lightbulb"
        }
        let tip = TestTip()
        let sut = TipBox(tip, isShowAnimationEnabled: false)

        let exp = sut.inspection.inspect { view in
            XCTAssertTrue(try view.actualView().isVisible)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }

    /// Test case for TipBox Close Button Action
    func testTipBoxCloseButtonAction() throws {
        struct TestTip: TipInfo {
            var title: String = "Test Title"
            var message: String = "Test Message"
            var image: String = "lightbulb"
        }
        let tip = TestTip()
        let sut = TipBox(tip, isShowAnimationEnabled: false)

        let exp = sut.inspection.inspect { view in
            let closeButton = try view.find(ViewType.Button.self)
            try closeButton.tap()
            XCTAssertFalse(try view.actualView().isVisible)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}
