//
//  ViewController.swift
//  Tareas
//
//  Created by Mac Tecsup on 11/04/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tareas:[Tarea] = []
    
    var indexSeleccionado = 0
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerTareas()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell()
        let tarea = tareas[indexPath.row]
        if tarea.importante{
            cel.textLabel?.text="🙀\(tarea.nombre!)"
        } else {
            cel.textLabel?.text = tarea.nombre!
        }
        return cel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSeleccionado = indexPath.row
        let tarea = tareas[indexPath.row]
        performSegue(withIdentifier: "tareaSeleccionadaSegue", sender: tarea)
    }
    
    
    @IBAction func agregarTarea(_ sender: Any) {
        performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
    
    func obtenerTareas(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tareas = try context.fetch(Tarea.fetchRequest()) as! [Tarea]
        } catch {
            print("HA OCURRIDO UN ERROR")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "tareaSeleccionadaSegue"{
            let siguienteVC = segue.destination as! TareaCompletadaViewController
            siguienteVC.tarea = sender as? Tarea
        }
    }

}

