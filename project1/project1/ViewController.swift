//
//  ViewController.swift
//  project1
//
//  Created by user on 01/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default // atribui o valor retornado pelo gerenciador
        let path = Bundle.main.resourcePath! // Define o caminho do recurso do nosso pacote
        let items = try! fm.contentsOfDirectory(atPath: path) // Definir o conteúdo do diretório em um caminho
        
        for item in items { // um loop percorrendo todos os itens encontrados no diretório
            if item.hasPrefix("nssl") { // Verifique se tem o prefixo nssl
                pictures.append(item)
            }
        }
        
        print(pictures)
    }


}

