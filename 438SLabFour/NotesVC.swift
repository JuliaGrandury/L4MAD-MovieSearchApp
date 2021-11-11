//
//  NotesVC.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/29/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import UIKit

class NotesVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesField: UITextView!
    let defaults = UserDefaults.standard

    var movie_title: String?
    var movie_index: Int?
    var newNote: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        //getNotes()
        notesField.reloadInputViews()
        notesField.layer.borderColor = UIColor.lightGray.cgColor
        notesField.layer.borderWidth = 1.0
        notesLabel.font = .systemFont(ofSize: 25.0)
        notesLabel.text = movie_title
        notesLabel.textAlignment = .center
    }
}

//    func textViewDidBeginEditing(_ textView: UITextView) {
//        let string = notesField.text
//        newNote = string!.trimmingCharacters(in: .whitespacesAndNewlines)
//        print("print newNote" + newNote!)
//        defaults.set(newNote, forKey: "\(movie_title ?? "")")
//        //print("print newNote" + newNote!)
//    }
//
////    func textViewDidEndEditing(_ textView: UITextView) {
////        newNote = notesField.text
////        defaults.set(newNote, forKey: "\(movie_title ?? "")")
////        print("print newNote" + newNote!)
////    }
//
//    func getNotes(){
//        let text = UserDefaults.standard.string(forKey:"\(movie_title)" ?? " ")
//        notesField.text = text
//        notesField.reloadInputViews()
//    }
//
//    //IBA function for clear button
//    //defaults.standard.removeObject(forKey: notesArray[indexPath.row])
//    //notesArray.remove(at: indexPath.row)
//    //defaults.standard.set(notesArray, forKey: currentNoteKey)
//    //NotesVC.reloadData()
//
//}
