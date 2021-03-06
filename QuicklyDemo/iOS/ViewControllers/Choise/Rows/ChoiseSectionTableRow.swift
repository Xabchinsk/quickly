//
//  Quickly
//

import Quickly

class ChoiseSectionTableRow: QTwoLabelTableRow {

    // MARK: Enum

    public enum Mode {
        case label
        case button
        case textField
        case image

        public var name: String {
            get {
                switch self {
                case .label: return "Label"
                case .button: return "Button"
                case .textField: return "TextField"
                case .image: return "Image"
                }
            }
        }
        public var detail: String {
            get {
                switch self {
                case .label: return "Pressed to open the QLabel component demonstration screen"
                case .button: return "Pressed to open the QButton component demonstration screen"
                case .textField: return "Pressed to open the QTextField component demonstration screen"
                case .image: return "Pressed to open the QImageView component demonstration screen"
                }
            }
        }
    }

    // MARK: Public property

    public private(set) var mode: Mode

    // MARK: Init

    public init(mode: Mode) {
        self.mode = mode

        super.init()

        self.primaryText = QStyledText(mode.name, style: TextStyle.title)
        self.secondaryText = QStyledText(mode.detail, style: TextStyle.subtitle)
        self.edgeInsets =  UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }

}
