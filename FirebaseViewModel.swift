//
//  FirebaseViewModel.swift
//  IphoneIpadFirebase
//
//  Created by Rober on 13-07-22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel: ObservableObject {
    
    @Published var show = false
    
    func login(email:String, password:String, completion: @escaping (_ done: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error )  in
            if user != nil {
                print("entro")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("error en firebase", error)
                }else{
                    print("erorr en la app")
                }
            }
        }
    }
    
    func createUser(email:String, password:String, completion: @escaping (_ done: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("entro y se registro")
                completion(true)
            }else{
                if let error = error?.localizedDescription {
                    print("error en firebase de registro", error)
                }else{
                    print("error en la app")
                }
            }
        }
        
        
    }
    
    //BBDD
    
    //guardar
    func save(titulo: String, desc: String, plataforma: String, portada: Data, completion: @escaping (_ done: Bool) -> Void) {
        
        let storage = Storage.storage().reference()
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada, metadata: metadata){data, error in
            if error == nil{
                print("guardo la imagen")
                //guardar text
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }
                guard let email = Auth.auth().currentUser?.email else { return }
                let campos : [String:Any] = ["titulo":titulo, "desc": desc, "portada": String(describing: directorio), "idUser":idUser, "email":email]
                db.collection(plataforma).document(id).setData(campos){error in
                    if let error = error?.localizedDescription{
                        print("erorr al guardar en firestore", error)
                    }else{
                        print("guardo todo")
                        completion(true)
                    }
                }
                //termino de guardar texto
                
            }else{
                if let error = error?.localizedDescription{
                    print("fallo al subir la imagen en el storage", error)
                }else{
                    print("fallo la app")
                }
            }
        }
    }
}
