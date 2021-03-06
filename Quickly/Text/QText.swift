//
//  Quickly
//

public class QText: IQText {

    public private(set) var attributed: NSAttributedString

    public init(_ text: String) {
        self.attributed = NSAttributedString(string: text)
    }

    public init(_ text: String, font: QPlatformFont) {
        self.attributed = NSAttributedString(string: text, attributes: [
            .font: font
        ])
    }

    public init(_ text: String, color: QPlatformColor) {
        self.attributed = NSAttributedString(string: text, attributes: [
            .foregroundColor: color
        ])
    }

    public init(_ text: String, font: QPlatformFont, color: QPlatformColor) {
        self.attributed = NSAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: color
        ])
    }

    public init(_ attributed: NSAttributedString) {
        self.attributed = attributed
    }

}
