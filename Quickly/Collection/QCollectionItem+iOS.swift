//
//  Quickly
//

#if os(iOS)

    open class QCollectionItem: IQCollectionItem {

        public var canSelect: Bool = true
        public var canDeselect: Bool = true
        public var canMove: Bool = false

        public init() {
        }

    }

#endif
