//
//  SQLiteDb.swift
//  SQLiteCrud
//
//  Created by ksolves on 07/01/20.
//  Copyright © 2020 ksolves. All rights reserved.
//

import SQLite3
import Foundation

class SQLiteDb {
    
    // MARK: Properties
    let dbURL: URL
    var db: OpaquePointer?
    
    var insertStatement: OpaquePointer?
    var readStatement: OpaquePointer?
    var updateStatement: OpaquePointer?
    var deleteStatement: OpaquePointer?
    
    init() {
        do {
            dbURL = try FileManager.default
                .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("integration.db")
        } catch {
            print("Error occured while initialising url")
            dbURL = URL(fileURLWithPath: "")
        }
        do {
            try openDB()
            try createTable()
        } catch {
            print("Error occured while opening database or creating table")
        }
    }
    
    // MARK: Opening Database
    func openDB() throws {
        if sqlite3_open(dbURL.path, &db) != SQLITE_OK {
            print("Error occured while opening database")
            throw SqliteError(message: "Error opening database")
        }
    }
    
    func createTable() throws {
        let sql = "CREATE TABLE IF NOT EXISTS UserData(FirstName TEXT NOT NULL PRIMARY KEY, LastName TEXT NOT NULL)"
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
            throw SqliteError(message: "Error creating table")
        }
    }
    
    func create(userData: UserData) {
        guard prepareCreateStatement() == SQLITE_OK else { print("Error preparing insert statement"); return}
        
        defer {
            sqlite3_reset(self.insertStatement)
        }
        
        if sqlite3_bind_text(self.insertStatement, 1, (userData.firstName as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding firstname")
            return
        }
        if sqlite3_bind_text(self.insertStatement, 2, (userData.lastName as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding lastname")
            return
        }
        
        if sqlite3_step(self.insertStatement) != SQLITE_DONE {
            print("Error executing insert statement")
            return
        }
    }
    
    func read() -> [UserData] {
        var userDataArray = [UserData]()

        guard prepareReadStatement() == SQLITE_OK else { print("Error preparing read statement"); return userDataArray}
        
        defer {
            sqlite3_reset(self.readStatement)
        }
        
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let tempUserData = UserData(firstName: String(cString: sqlite3_column_text(readStatement, 0)), lastName: String(cString: sqlite3_column_text(readStatement, 1)))
            userDataArray.append(tempUserData)
        }
        
        return userDataArray
    }
    
    func update(userData: UserData) {
        guard prepareUpdateStatement() == SQLITE_OK else { print("Error preparing update statement"); return
        }
        
        defer {
            sqlite3_reset(self.updateStatement)
        }
        
        if sqlite3_bind_text(self.updateStatement, 1, (userData.lastName as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding lastname")
            return
        }
        
        if sqlite3_bind_text(updateStatement, 2, (userData.firstName as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding firstname")
            return
        }
        
        if sqlite3_step(updateStatement) != SQLITE_DONE {
            print("Error executing update statement")
            return
        }
    }
    
    func delete(userData: UserData)
    {
        guard prepareDeleteStatement() == SQLITE_OK else { print("Error preparing delete statement"); return
        }
        
        defer {
            sqlite3_reset(self.deleteStatement)
        }
        
        if sqlite3_bind_text(deleteStatement, 1, (userData.firstName as NSString).utf8String, -1, nil) != SQLITE_OK {
            print("Error binding firstname")
            return
        }
        
        if sqlite3_bind_text(deleteStatement, 2, (userData.lastName as NSString).utf8String, -1, nil) != SQLITE_OK{
            print("Error binding lastname")
            return
        }
        
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Error executing delete statement")
            return
        }
    }
    func prepareCreateStatement() -> Int32 {
        let sql = "INSERT INTO UserData VALUES (?,?)"
        return sqlite3_prepare(db, sql, -1, &insertStatement, nil)
    }
    
    func prepareReadStatement() -> Int32 {
        let sql = "SELECT * FROM UserData"
        return sqlite3_prepare(db, sql, -1, &readStatement, nil)
    }
    
    func prepareUpdateStatement() -> Int32 {
        let sql = "UPDATE UserData SET LastName = ? WHERE FirstName = ?"
        return sqlite3_prepare(db, sql, -1, &updateStatement, nil)
    }
    
    func prepareDeleteStatement() -> Int32 {
        let sql = "DELETE FROM UserData WHERE FirstName = ? and LastName = ?"
        return sqlite3_prepare(db, sql, -1, &deleteStatement, nil)
    }
}


class SqliteError: Error {
    var message = ""
    var error = SQLITE_ERROR
    init(message: String = "") {
        self.message = message
    }
    init(error: Int32) {
        self.error = error
    }
}
