//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Keith Abdulla on 1/24/15.
//  Copyright (c) 2015 Keith Abdulla. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemsManager = ItemsManger()

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell;
        
        
        let item = itemsManager.items[indexPath.row]
        cell.textLabel!.text = item.name;
        
        // since this is a reusable cell then a cell could of been recycled
        // which is why we have to set the item to be the photo for nil
        if item.isComplete {
            cell.imageView!.image = item.photo
            cell.accessoryType = .Checkmark
        } else {
            cell.imageView!.image = nil
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell;
    }
    
    
    // respond to a tap on an index
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let indexPath = tableView.indexPathForSelectedRow() {
            let selectedItem = itemsManager.items[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as UIImage
            selectedItem.photo = photo;
            itemsManager.save()
            
            dismissViewControllerAnimated(true, completion: {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addItemController = segue.sourceViewController as AddViewController
            if let newItem = addItemController.newItem {
                itemsManager.items += [newItem]
                itemsManager.save()
                let indexPath = NSIndexPath(forRow: itemsManager.items.count-1, inSection: 0)
                
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
            }
        }
    }
    
}
