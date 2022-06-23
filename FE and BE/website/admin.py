from cmath import e
import email
from flask import Blueprint, render_template, request, make_response, redirect, flash, url_for, request, session, flash, jsonify
import pyodbc
import json
import random
from base64 import b64encode
admin  = Blueprint('admin', __name__)

# ---- CONNECTION TO GENERAL DB ----
conGen = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=GeneralDB;', autocommit=True)
cursorGen = conGen.cursor() 

# ---- CONNECTION TO PRODUCTS DB ----
conProd = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=ProductsDB;', autocommit=True)
cursorProd = conProd.cursor() 

# ---- CONNECTION TO SALES DB ----
conSales = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=SalesDB;', autocommit=True)
cursorSales = conSales.cursor() 


# ---------------------------- ADMIN EMPLOYEES ----------------------------

# -------- Defaul route --------
@admin.route('/adminEmp', methods=['GET', 'POST'])
def adminEmp():
    
    # Get the names of the employees
    q1 = 'EXEC getEmployeesNames'
    cursorGen.execute(q1)
    names = []
    for name in cursorGen:
        names.append(name)

    # Get the jobs of the employees
    q1 = 'EXEC getEmployeesJobs'
    cursorGen.execute(q1)
    jobs = []
    for job in cursorGen:
        jobs.append(job)

    return render_template("adminEmp.html", employees = names, jobs = jobs)

# -------- Modify Employees --------
@admin.route('/modifyEmp', methods=['GET', 'POST'])
def modifyEmp():

    # Get the names of the employees
    q1 = 'EXEC getEmployeesNames'
    cursorGen.execute(q1)
    names = []
    for name in cursorGen:
        names.append(name)
    
    # Get the jobs of the employees
    q1 = 'EXEC getEmployeesJobs'
    cursorGen.execute(q1)
    jobs = []
    for job in cursorGen:
        jobs.append(job)

    # Get the info of the form
    employeeID = request.form.get('employee')
    employeeNewJob = request.form.get('job')
    newSalary = request.form.get('salaryLocal')
    newSalaryDollars = request.form.get('salaryD')
    try:
        newSalary = float(newSalary)
        newSalaryDollars = float(newSalaryDollars)

        # Modify the employee 
        q1 = 'EXEC modifyEmployee @inIdEmployee =' + str(employeeID) + \
        ', @inJobID =' + str(employeeNewJob) + ', @inNewSallary = ' + str(newSalary) + \
        ', @inNewSallaryD = ' + str(newSalaryDollars)

        cursorGen.execute(q1)

        return render_template("adminEmp.html", employees = names, jobs = jobs)
    except:
        flash('The salaries must be numbers. Please try again', category="error")
        return render_template("adminEmp.html", employees = names, jobs = jobs)

# -------- Add Employees --------
@admin.route('/addEmp', methods=['GET', 'POST'])
def addEmp():

    # Get the names of the employees
    q1 = 'EXEC getEmployeesNames'
    cursorGen.execute(q1)
    names = []
    for name in cursorGen:
        names.append(name)
    
    # Get the jobs of the employees
    q1 = 'EXEC getEmployeesJobs'
    cursorGen.execute(q1)
    jobs = []
    for job in cursorGen:
        jobs.append(job)
    
    # Get the info of the form
    UserName = request.form.get('UserName')
    Password = request.form.get('Password')
    userType = request.form.get('userType')
    country = request.form.get('country')
    Name = request.form.get('Name')
    Surname = request.form.get('Surname')
    Email = request.form.get('Email')
    Phone = request.form.get('Phone')
    
    flagPhone = Phone.isdigit()
    
    if flagPhone:
        NameOnCard = request.form.get('NameOnCard')
        
        AccountNumber = request.form.get('AccountNumber')
        flagAccountNumber = AccountNumber.isdigit()
        
        if flagAccountNumber:
            
            ExpirationDate = request.form.get('ExpirationDate')
            
            CVV = request.form.get('CVV')
            flagCVV = CVV.isdigit()
            
            if flagCVV:
                paymethod = request.form.get('paymethod')
                IdJob = request.form.get('IdJob')
                
                salaryLocal = request.form.get('salaryLocal')
                flagsalaryLocal = salaryLocal.isdigit()
                
                if flagsalaryLocal:
                    salaryD = request.form.get('salaryD')
                    flagsalaryD = salaryD.isdigit()

                    if flagsalaryD:
                        
                        # Add the employee
                        query = 'EXEC addEmployee @inUserName =' + str(UserName) + \
                        ', @inPassword =' + str(Password) + ', @inidUserType =' + userType + \
                        ', @idCountry =' + str(country) + ', @inEmail = ' + "'" + str(Email) + "'" + \
                        ', @inName =' + str(Name) + ', @inSurname =' + str(Surname) + \
                        ', @inPhone =' + str(Phone) + ', @inIdPayMethod =' + str(paymethod) + \
                        ', @inNameOnCard =' + "'" + str(NameOnCard) + "'" + \
                        ', @inAccountNumber =' + str(AccountNumber) + \
                        ', @inExpirationDate =' + "'" + str(ExpirationDate) + "'" + \
                        ', @inCVV =' + str(CVV) + ', @inIdJob =' + str(IdJob) + \
                        ', @inSalaryLocal =' + str(salaryLocal) + \
                        ', @inSalaryDollars =' + str(salaryD)

                        cursorGen.execute(query)

                        flash('Employee Added', category="success")
                        return render_template("adminEmp.html", employees = names, jobs = jobs)
                    
                    else:
                        flash('Salary in Dollars must be a number', category="error")
                        return render_template("adminEmp.html", employees = names, jobs = jobs) 
                else:
                    flash('Local Salary must be a number', category="error")
                    return render_template("adminEmp.html", employees = names, jobs = jobs)   
            else:
                flash('Account Number must be a number', category="error")
                return render_template("adminEmp.html", employees = names, jobs = jobs)                   
        else:
            flash('Account Number must be a number', category="error")
            return render_template("adminEmp.html", employees = names, jobs = jobs)        
    else:
        flash('Phone must be a number', category="error")
        return render_template("adminEmp.html", employees = names, jobs = jobs)

# -------- Delete Employees --------
@admin.route('/deleteEmp', methods=['GET', 'POST'])
def deleteEmp():
    
    # Get the info of the form
    employeeID = request.form.get('employee')
    print(employeeID)
    # Delete employee
    query = 'EXEC deleteEmployee @inIdEmployee =' + str(employeeID)
    cursorGen.execute(query)
    
    # Get the names of the employees
    q1 = 'EXEC getEmployeesNames'
    cursorGen.execute(q1)
    names = []
    for name in cursorGen:
        names.append(name)
    
    # Get the jobs of the employees
    q1 = 'EXEC getEmployeesJobs'
    cursorGen.execute(q1)
    jobs = []
    for job in cursorGen:
        jobs.append(job)

    flash('Employee Deleted', category="success")
    return render_template("adminEmp.html", employees = names, jobs = jobs)


# ---------------------------- ADMIN USERS ----------------------------

@admin.route('/adminUserRep', methods=['GET', 'POST'])
def adminUserRep():


    return render_template("adminUserRep.html")



# ---------------------------- ADMIN SUSCRIPTIONS ----------------------------
@admin.route('/adminSuscriptions', methods=['GET', 'POST'])
def adminSuscriptions():

    # Get the names of the current suscriptions
    query = 'EXEC readSuscriptionsNames'
    cursorGen.execute(query)
    names = []
    for i in cursorGen:
        names.append(i)

    return render_template("adminSuscriptions.html", names = names)

# -------- Add suscription --------
@admin.route('/addSusType', methods=['GET', 'POST'])
def addSusType():

    # Get info from the form
    Name = request.form.get('Name')
    DiscountOrder = request.form.get('DiscountOrder')
    DiscountShipping = request.form.get('DiscountShipping')
    canSee = request.form.get('canSee')
    present = request.form.get('present')
    notifications = request.form.get('notifications')
    Price = request.form.get('Price')

    # Add suscription
    query2 = 'EXEC createSubType @inname=' + "'" + str(Name) + "'" + ', @indicosuntBuy=' + str(DiscountOrder) + \
    ', @indiscountShipping=' + str(DiscountShipping) + ', @incanSee=' + str(canSee) + \
    ', @inpresent=' + str(present) + ', @inemailNotifications=' + str(notifications) + \
    ', @inprice=' + str(Price)
    cursorGen.execute(query2)

    # Get the names of the current suscriptions
    query = 'EXEC readSuscriptionsNames'
    cursorGen.execute(query)
    names = []
    for i in cursorGen:
        names.append(i)
    return render_template("adminSuscriptions.html", names = names)


# -------- Modify suscription --------
@admin.route('/ModifySusType', methods=['GET', 'POST'])
def ModifySusType():

    # Get info from the form
    Name = request.form.get('Name')
    DiscountOrder = request.form.get('DiscountOrder')
    DiscountShipping = request.form.get('DiscountShipping')
    canSee = request.form.get('canSee')
    present = request.form.get('present')
    notifications = request.form.get('notifications')
    Price = request.form.get('Price')
    idCategory = request.form.get('category')
    # Modify suscription
    query2 = 'EXEC ModifySubType @inname=' + "'" + str(Name) + "'" + ', @indicosuntBuy=' + str(DiscountOrder) + \
    ', @indiscountShipping=' + str(DiscountShipping) + ', @incanSee=' + str(canSee) + \
    ', @inpresent=' + str(present) + ', @inemailNotifications=' + str(notifications) + \
    ', @inprice=' + str(Price) + ', @inIdSubType=' + str(idCategory)
    cursorGen.execute(query2)


    # Get the names of the current suscriptions
    query = 'EXEC readSuscriptionsNames'
    cursorGen.execute(query)
    names = []
    for i in cursorGen:
        names.append(i)
    return render_template("adminSuscriptions.html", names = names)

# -------- Delete suscription --------
@admin.route('/deleteSusType', methods=['GET', 'POST'])
def deleteSusType():

    # Get info from the form
    idCategory = request.form.get('category')

    # Modify suscription
    query2 = 'EXEC DeleteSubType @inIdSubType=' + str(idCategory)
    cursorGen.execute(query2)


    # Get the names of the current suscriptions
    query = 'EXEC readSuscriptionsNames'
    cursorGen.execute(query)
    names = []
    for i in cursorGen:
        names.append(i)
    return render_template("adminSuscriptions.html", names = names)


# ---------------------------------------- ADMIN COINS -----------------------------------------------------

@admin.route('/adminCoins', methods=['GET', 'POST'])
def adminCoins():
    
    # Get the names
    query = 'EXEC readCoins'
    cursorProd.execute(query)
    coins = []
    for coin in cursorProd:
        coins.append(coin)

    return render_template("adminCoins.html", coins = coins)

@admin.route('/addCoin', methods=['GET', 'POST'])
def addCoin():
    
    # Get the info from the form
    Name = request.form.get('Name')
    symbol = request.form.get('symbol')
    country = request.form.get('country')
    
    # Add coin
    query1 = 'EXEC createCoin @name=' + "'" + str(Name) + "'" + ', @symbol=' + str(symbol) +\
    ', @country='+ "'" + str(country) + "'" 
    print(query1)
    cursorProd.execute(query1)

    # Get the names
    query = 'EXEC readCoins'
    cursorProd.execute(query)
    coins = []
    for coin in cursorProd:
        coins.append(coin)
    return render_template("adminCoins.html", coins = coins)

@admin.route('/modifyCoin', methods=['GET', 'POST'])
def modifyCoin():
    
    # Get the info from the form
    coinId = request.form.get('coinId')
    Name = request.form.get('Name')
    symbol = request.form.get('symbol')
    country = request.form.get('country')
    
    # Modify coin
    query1 = 'EXEC modifyCoin @name=' + "'" + str(Name) + "'" + ', @symbol=' + str(symbol) +\
    ', @country='+ "'" +str(country) + "'" + ', @coinId=' + str(coinId)
    cursorProd.execute(query1)

    # Get the names
    query = 'EXEC readCoins'
    cursorProd.execute(query)
    coins = []
    for coin in cursorProd:
        coins.append(coin)

    return render_template("adminCoins.html", coins = coins)

@admin.route('/deleteCoin', methods=['GET', 'POST'])
def deleteCoin():

    # Get the info from the form
    coinId = request.form.get('coinId')

    # Delete coin
    query1 = 'EXEC deleteCoin @coinId=' + str(coinId)
    cursorProd.execute(query1)
    
    # Get the names
    query = 'EXEC readCoins'
    cursorProd.execute(query)
    coins = []
    for coin in cursorProd:
        coins.append(coin)
    return render_template("adminCoins.html", coins = coins)

# ---------------------------------------- USERS REPORT -----------------------------------------------------
@admin.route('/usersReport', methods=['GET', 'POST'])
def usersReport():
    # Get the info of the form
    country = request.form.get('country')
    CountryChBox = request.form.get('CountryChBox')

    suscription = request.form.get('suscription')
    suscriptionChBox = request.form.get('suscriptionChBox')

    Sales = request.form.get('Sales')
    SalesChBox = request.form.get('SalesChBox')

    shipping = request.form.get('shipping')
    shippingChBox = request.form.get('shippingChBox')

    date = request.form.get('date')
    dateChBox = request.form.get('dateChBox')

    # Set null values to those that were not checked
    if(CountryChBox == None):
        country = None
    if(suscriptionChBox == None):
        suscription = None
    if(SalesChBox == None):
        Sales = None
    if(shippingChBox == None):
        shipping = None
    if(dateChBox == None):
        date = None
    
    cursorGen.execute("EXEC usersReport @subType=?, @countryId=?, @saleId =?, @shipping=?, @date=?", 
    (suscription, country, Sales,shipping, date))
    cursorGen.commit()

    usersReport = []
    for user in cursorGen:
        if(user.country == 1):
            user.country = 'Ireland'
        if(user.country == 2):
            user.country = 'Scotland'
        if(user.country == 3):
            user.country = 'United States'    
        usersReport.append(user)

    # Get the names of the current suscriptions
    query = 'EXEC readSuscriptionsNames'
    cursorGen.execute(query)
    names = []
    for i in cursorGen:
        names.append(i)

    return render_template("adminUserRep.html", names = names, 
    usersReport = usersReport)



# ---------------------------------------- EMPLOYEES REPORT -----------------------------------------------------
@admin.route('/employeesReport', methods=['GET', 'POST'])
def employeesReport():
    # Get the info of the form
    Department = request.form.get('Department')
    DepartmentChBox = request.form.get('DepartmentChBox')

    Calification = request.form.get('Calification')
    CalificationChBox = request.form.get('CalificationChBox')

    Salary = request.form.get('Salary')
    SalaryChBox = request.form.get('SalaryChBox')


    # Set null values to those that were not checked
    if(DepartmentChBox == None):
        Department = None
    if(CalificationChBox == None):
        Calification = None
    if(SalaryChBox == None):
        Salary = None

    
    cursorGen.execute("EXEC employeesReport @deparmentID=?, @salary =?, @calification=?;", 
    (Department, Calification, Salary))
    cursorGen.commit()
    

    employeesReport = []
    for employee in cursorGen:
        if(employee.idjob == 1):
            employee.idjob = 'Seller'
        if(employee.idjob == 2):
            employee.idjob = 'Deliever'
        if(employee.idjob == 3):
            employee.idjob = 'Supervisor'    
        employeesReport.append(employee)

    # Get the names of the employees
    q1 = 'EXEC getEmployeesNames'
    cursorGen.execute(q1)
    names = []
    for name in cursorGen:
        names.append(name)

    # Get the jobs of the employees
    q1 = 'EXEC getEmployeesJobs'
    cursorGen.execute(q1)
    jobs = []
    for job in cursorGen:
        jobs.append(job)

    return render_template("adminEmp.html", employees = names, 
    jobs = jobs, employeesReport = employeesReport)