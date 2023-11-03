//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 김준성 on 11/1/23.
//

import Foundation

class Bank: Bankable {
    private var customerQueue: Queue<Customer>
    private(set) var bankClerk: Int
    private(set) var processingTime: Double
    
    init(customerQueue: Queue<Customer> = Queue<Customer>(), bankClerk: Int, processingTime: Double) {
        self.customerQueue = customerQueue
        self.bankClerk = bankClerk
        self.processingTime = processingTime
    }
    
    func beginTask(customerCount: Int) -> (taskProcessingTime: Double, handledCustomer: Int) {
        configureQueue(customerCount: customerCount)
        
        var taskProcessingTime: Double = 0
        var handledCustomer = 0
        
        while !customerQueue.isEmpty {
            guard let customer = customerQueue.dequeue() else {
                break
            }
            
            print(BankDialogue.start(customer))
            taskProcessingTime += processingTime
            Thread.sleep(forTimeInterval: processingTime)
            print(BankDialogue.finish(customer))
            handledCustomer += 1
        }
        
        clearQueue()
        
        return (taskProcessingTime, handledCustomer)
    }
    
    private func configureQueue(customerCount: Int) {
        var queue = Queue<Customer>()
        for i in 1...customerCount {
            queue.enqueue(Customer(id: i))
        }
        customerQueue = queue
    }
    
    private func clearQueue() {
        customerQueue.clear()
    }
}
