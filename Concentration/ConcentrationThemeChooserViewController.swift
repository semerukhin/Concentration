//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Ilya Semerukhin on 12.05.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
   
   let themes = [
      "Sports":  "⚽️🏀🏈⚾️🎾🏐🏉🎱🥌🏓",
      "Faces":   "😀😄😅☺️😉😘🙁😢🤔😬",
      "Animals": "🐶🐭🐹🦊🐼🐷🦁🐵🐨🐻"
   ]
   
   @IBAction func changeTheme(_ sender: Any) {
      performSegue(withIdentifier: "Choose Theme", sender: sender)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "Choose Theme" {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            if let cvc = segue.destination as? ConcentrationViewController {
               cvc.theme = theme
            }
         }
      }
   }
   
}





