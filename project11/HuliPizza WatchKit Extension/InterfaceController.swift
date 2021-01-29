//
//  InterfaceController.swift
//  HuliPizza WatchKit Extension
//
//  Created by Ashlee Muscroft on 07/10/2020.
//
import Combine
import Foundation
import WatchKit

class InterfaceController: WKInterfaceController {
    fileprivate var cancellable : AnyCancellable?
    let menu = MenuModel.menu
    @IBOutlet weak var clearSelectionBtn: WKInterfaceButton!
    @IBAction func doClearSelection() {
        self.selectedItemLabel.setText("Menu")
        SelectedItem.current.selected = nil
    }
    @IBOutlet weak var table: WKInterfaceTable!
    @IBOutlet weak var selectedItemLabel: WKInterfaceLabel!
    
    func loadTable(){
        //establish how big the table is
        table.setNumberOfRows(menu.count, withRowType: "row")
        for index in 0..<menu.count {
            guard let row = self.table.rowController(at: index) as? RowController else { continue }
            //This RowController has a image and label
            row.label.setText(menu[index].name)
            row.image.setImageNamed("\(menu[index].id)_100w")
        }
    }
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        loadTable()
        selectedItemLabel.setText("Awake!")
        clearSelectionBtn.setBackgroundColor(.red)
        
        cancellable = SelectedItem.current.$selected.receive(on: DispatchQueue.main).sink{ menuitem in
            self.selectedItemLabel.setText(menuitem?.name)
        }
        
    }
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        //a context is a dictionary with the "details" from one controller to the other.
        pushController(withName: "DetailController", context: menu[rowIndex])
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}

