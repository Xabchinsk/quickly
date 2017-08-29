//
//  Quickly
//

import Quickly

class ChoiseViewController: QTableViewController, IQRouted {

    public var router: ChoiseRouter?
    public var container: IQContainer {
        get { return self.router!.container }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tc: ChoiseTableController = ChoiseTableController(self)
        tc.sections = [
            QTableSection(rows: [
                ChoiseSectionTableRow(mode: .label),
                ChoiseSectionTableRow(mode: .button),
                ChoiseSectionTableRow(mode: .textField)
            ])
        ]
        self.tableController = tc
    }

}

extension ChoiseViewController: ChoiseTableControllerDelegate {

    public func pressedChoiseSectionRow(_ row: ChoiseSectionTableRow) {
        if let router: ChoiseRouter = self.router {
            switch row.mode {
            case .label: router.presentLabelViewController()
            case .button: router.presentButtonViewController()
            case .textField: router.presentTextFieldViewController()
            }
        }
    }
    
}
