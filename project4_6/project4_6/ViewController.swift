//
//  ViewController.swift
//  project4_6
//
//  Created by user on 15/08/22.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = "Lista de Compras"
    }

    func addItem(item: String) {
        if itemAlreadyPresent(item: item) {
            let ac = UIAlertController(title: "Item repetido", message: "\"\(item)\" ja está na sua lista de compras.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
            return
        }
        
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func itemAlreadyPresent(item: String) -> Bool {
        return shoppingList.contains(where: {
            $0.compare(item, options: .caseInsensitive) == .orderedSame
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        
        let avc = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }

    
    @objc func addTapped() {
        let ac = UIAlertController(title: "Novo item de compra", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let addAction = UIAlertAction(title: "Adicionar", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {
                return
            }
            
            self?.addItem(item: item)
        }
        ac.addAction(addAction)

        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        present(ac, animated: true)
    }
}
