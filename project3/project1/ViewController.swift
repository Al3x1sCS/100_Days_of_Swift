//
//  ViewController.swift
//  project1
//
//  Created by user on 01/08/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)) // Challenge 2 - Projeto 3
        
        let fm = FileManager.default // atribui o valor retornado pelo gerenciador
        
        let path = Bundle.main.resourcePath! // Define o caminho do recurso do nosso pacote
        let items = try! fm.contentsOfDirectory(atPath: path) // Definir o conteúdo do diretório em um caminho
        
        for item in items { // um loop percorrendo todos os itens encontrados no diretório
            if item.hasPrefix("nssl") { // Verifique se tem o prefixo nssl
                pictures.append(item)
            }
        }
        pictures.sort() // Challenge 2
        
//        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            vc.position = (position: indexPath.row + 1, total: pictures.count) // Challenge 3
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {  // Challenge 2 - Projeto 3
        var items: [Any] = ["Veja meu codigo no GITHUB!"]
        if let url = URL(string: "https://github.com/Al3x1sCS/100_Days_of_Swift/tree/main/project3") {
            items.append(url)
        }
        
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    } // Challenge 2 - Projeto 3
}

