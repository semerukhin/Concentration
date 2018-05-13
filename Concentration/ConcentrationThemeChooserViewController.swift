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
      if let cvc = splitViewDetailConcentrationViewController {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
         }
      } else if let cvc = lastSeguedToConcentrationViewController {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
         }
         navigationController?.pushViewController(cvc, animated: true)
      } else {
         performSegue(withIdentifier: "Choose Theme", sender: sender)
      }
   }
   
   private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
      return splitViewController?.viewControllers.last as? ConcentrationViewController
   }
   
   private var lastSeguedToConcentrationViewController: ConcentrationViewController?
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "Choose Theme" {
         if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            if let cvc = segue.destination as? ConcentrationViewController {
               cvc.theme = theme
               lastSeguedToConcentrationViewController = cvc
            }
         }
      }
   }
   
}





