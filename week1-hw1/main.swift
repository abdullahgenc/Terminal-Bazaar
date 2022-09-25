//
//  main.swift
//  week1-hw1
//
//  Created by Abdullah Genc on 25.09.2022.
//

import Foundation

// MARK: - Protocol, Struct and Classes
protocol Sellable {
    var price: Double { get set }
    var installment: Int { get set }
}

struct User {
    var name: String
    var age: Int
    var job: String
    
    init(name: String, age: Int, job: String) {
        self.name = name
        self.age = age
        self.job = job
    }
}

class Product: Sellable {
    var price: Double
    var installment: Int
    
    var isSold: Bool
    var description:String
    var productPoint: Double
    
    init(price: Double, installment: Int, isSold: Bool, description: String, productPoint: Double) {
        self.price = price
        self.installment = installment
        self.isSold = isSold
        self.description = description
        self.productPoint = productPoint
    }
}

class Laptop: Product {
    override init(price: Double = 6995.99,
                  installment: Int = 12,
                  isSold: Bool = false,
                  description: String = "The Apple Macbook is the most iconic computer of all time. The Macbook is a laptop that is sleek, lightweight, and portable. The Macbook is often used as a business computer, or even a college computer. The Macbook features a retina display and features.",
                  productPoint: Double = 8.9) {
        super.init(price: price, installment: installment, isSold: isSold, description: description, productPoint: productPoint)
    }
}

class Stethoscope: Product {
    override init(price: Double = 2450.00,
                  installment: Int = 4,
                  isSold: Bool = true,
                  description: String = "A stethoscope is a medical device used to listen to sounds made by the lungs, heart, and other parts of the body. It is typically used to hear abnormalities of the heart and lungs and is a must-have for any medical student.",
                  productPoint: Double = 9.7) {
        super.init(price: price, installment: installment, isSold: isSold, description: description, productPoint: productPoint)
    }
}

class SketchPen: Product {
    override init(price: Double = 349.99,
                  installment: Int = 2,
                  isSold: Bool = true,
                  description: String = "Sketch pens are a popular tool for drawing and coloring. They can be used to draw on a variety of surfaces including paper, fabric, wood, and glass. They are often used by artists and crafters, and are an inexpensive tool that is easy to use.",
                  productPoint: Double = 7.8) {
        super.init(price: price, installment: installment, isSold: isSold, description: description, productPoint: productPoint)
    }
}

class Rosary: Product {
    override init(price: Double = 185.00,
                  installment: Int = 2,
                  isSold: Bool = false,
                  description: String = "This rosary is a beautiful combination of natural materials and gemstones. It is made of turquoise and other gems, which are a common theme in Turkish culture.",
                  productPoint: Double = 10.0) {
        super.init(price: price, installment: installment, isSold: isSold, description: description, productPoint: productPoint)
    }
}

// MARK: - Data Initialization
// Subclasses are initialized.
let laptop = Laptop()
let stethoscope = Stethoscope()
let sketchPen = SketchPen()
let rosary = Rosary()

// Dictionary structure was used to make product recommendations according to the job.
let jobsAndProducts: [String : Product] = ["developer" : laptop,
                                          "doctor" : stethoscope,
                                          "architect" : sketchPen,
                                          "driver" : rosary]

// MARK: - Functions
func register() -> User {
    var firstUser = User(name: "-", age: 0, job: "-")
    
    // Personal informations are retrieved from the user for registration.
    print("Please enter your name:")
    if let input = readLine() {
        firstUser.name = input.capitalized
        print("You entered: \(input)")
    }
    
    print("\nPlease enter your age:")
    if let number = readLine() {
        if let input = Int(number) {
            firstUser.age = input
            print("You entered: \(input)")
        }
    }
    
    print("\nPlease enter your job:")
    if let input = readLine() {
        firstUser.job = input.lowercased()
        print("You entered: \(input)\n\n")
    }
    
    return firstUser
}

func mainMenu() {
    var registeredUser = register()
    var wannaContinue: Bool = true
    
    // It has been placed in a while loop for menu design.
    while wannaContinue {
        wannaContinue = false
        // It is checked whether there is a product according to the job of the user.
        if let filteredProduct = jobsAndProducts[registeredUser.job] {
            
            // It is checked whether the product is in stock.
            if filteredProduct.isSold == false {
                print("\nHey \(registeredUser.name)! Here are the products for you\n")
                print("Product Type : \(String(describing: type(of: filteredProduct)))")
                print("Price : \(filteredProduct.price) TRY")
                print("Description : \(filteredProduct.description)")
                print("Product Point : \(filteredProduct.productPoint)/10.0")
                print("Number of Installments : \(filteredProduct.installment)")
                print("\nPlease press P to purchase, A to add a new user, Q to exit.")

                if let input = readLine() {
                    switch input.uppercased() {
                    case "P":
                        print("\nCongratulations, you have successfully purchased!\n")
                        filteredProduct.isSold = true
                    case "A":
                        mainMenu()
                    case "Q":
                        break
                    default:
                        print("Invalid Input\n")
                    }
                }
            } else {
                print("We have run out of stock of items suitable for you. Please press T to try again.\n")
                
                // Product stock is renewed and the user is offered the opportunity to purchase the product.
                if let input = readLine() {
                    switch input.uppercased() {
                    case "T":
                        filteredProduct.isSold = false
                        wannaContinue = true
                    default:
                        print("Invalid Input\n")
                    }
                }
            }
        } else {
            print("\nThere are currently no products suitable for you. Please press C to change job, Q to exit.")
            if let input = readLine() {
                switch input.uppercased() {
                case "C":
                    wannaContinue = true
                    print("\nPlease enter your job:")
                    if let input = readLine() {
                        registeredUser.job = input.lowercased()
                        print("You entered: \(input)\n")
                    }
                case "Q":
                    break
                default:
                    print("Invalid Input\n")
                }
            }
        }
    }
}

// MARK: - Main Method
mainMenu()







