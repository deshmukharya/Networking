//
//  ViewController.swift
//  Networking
//
//  Created by E5000861 on 12/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    public var identifier = "ViewControllerID"
    var urlSession: URLSession = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func getCall(_sender: Any) {
        let url = URL(string : "https://jsonplaceholder.typicode.com/users")!
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data , response , error in
            
            guard let data = data else {
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                for post in posts{
                    print("User Id",post.id)
                    print("Name",post.name)
                    print("Username",post.username)
                    print("Address",post.address)
                    print("Company",post.company)
                }
            }catch let jsonError {
                print("Cannot print data",jsonError)
            }
        }
        task.resume()
        
    }
    
    @IBAction func putCall(_ sender: Any) {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let updatedUser = Post(id: 1, name: "Arya", username: "arya", website: "updatedansk", address: Address(city: "updatedaakn"), company: Company(name: "updatedinnov"))
            
            do {
                let jsonData = try JSONEncoder().encode(updatedUser)
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error:", error)
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Status Code:", httpResponse.statusCode)
                        
                        if let data = data {
                            do {
                                let responseData = try JSONSerialization.jsonObject(with: data, options: [])
                                print("Response Data: \(responseData)")
                                
                                // Handle parsing of responseData if needed
                            } catch {
                                print("Error parsing response data:", error)
                            }
                        }
                    }
                }
                task.resume()
            } catch {
                print("Error encoding data:", error)
            }
        }

    
    @IBAction func deleteCall(_ sender: Any) {
            let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error:", error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code:", httpResponse.statusCode)
                    
                    if let data = data {
                        do {
                            let responseData = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Response Data: \(responseData)")
                            
                            // Handle parsing of responseData if needed
                        } catch {
                            print("Error parsing response data:", error)
                        }
                    }
                }
            }
            task.resume()
        }
    
    @IBAction func postCall(_ sender: Any) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUser = Post(id: 21, name: "Arya", username: "arya", website: "ansk", address: Address(city: "aakn"), company: Company(name: "innov"))
        
        do {
            let jsonData = try JSONEncoder().encode(newUser)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error:", error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code:", httpResponse.statusCode)
                    
                    if let data = data {
                        do {
                            let responseData = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Response Data: \(responseData)")
                            
                            // Handle parsing of responseData if needed
                        } catch {
                            print("Error parsing response data:", error)
                        }
                    }
                }
            }
            task.resume()
        } catch {
            print("Error encoding data:", error)
        }
    }

    }



    

