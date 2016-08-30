//
//  ItemDetailVC.swift
//  DreamLister
//
//  Created by Anthony Washington on 9/10/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController,
                    UIPickerViewDataSource,
                    UIPickerViewDelegate,
                    UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
   
    private var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        
        self.imagePicker.delegate = self
        self.storePicker.delegate = self
        self.storePicker.dataSource = self
        
        // set back bar title 
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                        style: UIBarButtonItemStyle.plain,
                                                        target: nil,
                                                        action: nil)
        }
        
        self.getStores()
        
        if itemToEdit != nil { loadItemData() }
    }
    
    
    // set title for pickerview row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    
    // pickerview columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // return num of items in pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    
    // row selected in pickerview 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    // retrieve stores from database using fetch request
    func getStores() {
    
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
                self.stores = try context.fetch(fetchRequest)
                self.storePicker.reloadAllComponents()
        
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
            picture.image = thumbImage.image
    
        
        if itemToEdit == nil { item = Item(context: context) }
        else { item = itemToEdit }
        
        item.toImage = picture
        
        if let title = titleField.text { item.title = title }
        if let price = priceField.text { item.price = (price as NSString).doubleValue }
        if let details = detailsField.text { item.details = details }
        
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]

        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    func loadItemData() {
    
        if let item = itemToEdit {
        
            titleField.text = item.title
            priceField.text = String(item.price)
            detailsField.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                            storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                }while( index < stores.count )
            }
        }
    }
}
