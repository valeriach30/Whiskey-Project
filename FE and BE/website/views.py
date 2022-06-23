from cmath import e
import email
from flask import Blueprint, render_template, request, make_response, redirect, flash, url_for, request, session, flash, jsonify
import pyodbc
import json
import random
from base64 import b64encode
from flask import current_app
from flask_mail import Mail, Message
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

mail = Mail(current_app)
views  = Blueprint('views', __name__)

# Stores the list of products
productsG = []

# Stores the products added to the shopping cart
cart = []

# Stores the categories of the products
categoriesG = []

# Stores the id of the suscription 
Idsuscription = 0

# Stores the shopping cart but only with the idProduct and the quantity
cartQuant = []

# Stores the coordinates of the address location when buying
coordinates = []

# Stores the locations of a user
locationsG = []

# Stores the payment method of a user
cardStringG = ''

# Stores all the evaluations
evaluationsG = []

# Stores the orders of a user
ordersG = []

# ---- CONNECTION TO GENERAL DB ----
conGen = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=GeneralDB;', autocommit=True)
cursorGen = conGen.cursor() 

# ---- CONNECTION TO PRODUCTS DB ----
conProd = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=ProductsDB;', autocommit=True)
cursorProd = conProd.cursor() 

# ---- CONNECTION TO SALES DB ----
conSales = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=SalesDB;', autocommit=True)
cursorSales = conSales.cursor() 


# ---- SET COOKIE OF THE COUNTRY ----

# Used when the page is first initialized
@views.route('/setcookie', methods = ['POST', 'GET'])
def setcookie(): 
    cont = request.form.get('country')
    resp = redirect("http://127.0.0.1:5000/products")
    resp.set_cookie('country', cont)
    return resp

# ---------------------------- DEFAULT ROUTE ----------------------------

@views.route('/')
def home():
    if(request.form.get('country') == None):
        resp = redirect("http://127.0.0.1:5000/home")
        resp.set_cookie('country', '1')
        resp.set_cookie('isSuscribed', '0')
        return resp
    else:
        render_template("home.html", 
        country=request.cookies.get('country'), user=request.cookies.get('user'))

# ---------------------------- PRODUCTS ROUTE ----------------------------

@views.route('/products', methods=['GET', 'POST'])
def products():

    countryid = request.cookies.get('country')

    # Get products and their info
    querystring = 'EXEC ReadProducts @visibleId =' + str(request.cookies.get('isSuscribed'))
    cursorProd.execute(querystring)
    products = []
    
    # Encode the images of the products
    for product in cursorProd:
        product.productImage = b64encode(product.productImage).decode("utf-8")
        products.append(product)
    
    # Save in global variable
    global productsG
    productsG = products
    
    # Get the names of the categories for the sidebar
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    categories = cursorProd.fetchall()

    # Save in global variable
    global categoriesG
    categoriesG = categories
    
    return render_template("products.html", categories = categoriesG,
    country=countryid, products = products)

# ---------------------------- 1 PRODUCT ROUTE ----------------------------

@views.route('/product', methods=['GET', 'POST'])
def product():
    
    countryid = request.cookies.get('country')
    
    # Get the button id
    button = request.args.get('buttonId')
    
    # Get products and their info
    products = productsG

    # Get the info of the selected product
    idProd = int(button)-1
    
    prod = products[idProd]
    realIdProd = prod.idProduct
    
    # Get the reviews of the product
    query = 'exec ReadReview @productId = ' + str(realIdProd)
    cursorGen.execute(query)
    reviews = []
    for review in cursorGen:
        reviews.append(review)
    
    quantityReviews = len(reviews)
    
    return render_template("product.html", categories = categoriesG,
    country=request.cookies.get('country'), prod = prod, 
    quantityReviews = quantityReviews, reviews =reviews)


# ---------------------------- ORDER PRODUCTS ROUTE ----------------------------

@views.route('/orderProducts', methods=['GET', 'POST'])
def orderProducts():
    global productsG
    countryid = request.cookies.get('country')
    
    option = request.form['option']
    
    cat = categoriesG

    # Determine which store procedure must be executed

    # ----------------------- Cheapest to most expensive -----------------------
    if option == '1':
        # Get products and their info
        q1 = 'EXEC orderProductsByPriceASC @visibleId =' + request.cookies.get('isSuscribed')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)

        # Save in global variable
        productsG = products
        
        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)
    
    # ----------------------- Most expensive to chepeast  -----------------------
    elif option == '2':
        # Get products and their info
        q1 = 'EXEC orderProductsByPriceDESC @visibleId =' + request.cookies.get('isSuscribed')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)

        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)
    
    # ----------------------- Nearest Available  -----------------------
    elif option == '3':
    
        # Get products and their info
        q1 = 'EXEC readProdcutsByNear @countryId =' + request.cookies.get('country')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)

        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)
    
    # ----------------------- Furthest  Available -----------------------
    elif option == '4':
        
        # Get products and their info
        q1 = 'EXEC readProdcutsByFar @countryId =' + request.cookies.get('country')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)

        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)

    # ----------------------- Most Popular -----------------------
    elif option == '5':
        # Get products and their info
        q1 = 'EXEC orderProductsByPopularDESC @visibleId =' + request.cookies.get('isSuscribed')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)
        
        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)
    
    # ----------------------- Least Popular -----------------------
    elif option == '6':
        # Get products and their info
        q1 = 'EXEC orderProductsByPopularASC @visibleId =' + request.cookies.get('isSuscribed')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)
        
        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)
    
    # ----------------------- CATEGORIES -----------------------
    else:
        # Get products and their info
        q1 = 'EXEC readProdcutsByCat @productType = ' + "'" + option + "'" + ', @visibleId =' + request.cookies.get('isSuscribed')
        cursorProd.execute(q1)
        products = []
        
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)
        
        # Save in global variable
        productsG = products

        return render_template("products.html", categories = cat,
        country=request.cookies.get('country'), products = products)


# ---------------------------- SEARCH PRODUCT BY NAME ROUTE ----------------------------

@views.route('/searchName', methods=['GET', 'POST'])
def searchName():
    cat = categoriesG
    countryid = request.cookies.get('country')

    # Get the name from the form
    name = request.form.get('nameSearch')

    # Get products and their info
    q1 = 'EXEC getProductByName @productName =' + " '"+ str(name) + "' " + ', @visibleId =' + request.cookies.get('isSuscribed')

    cursorProd.execute(q1)
    products = []
    try:
        # Encode the images of the products
        for product in cursorProd:
            product.productImage = b64encode(product.productImage).decode("utf-8")
            products.append(product)

        # Save in global variable
        global productsG
        productsG = products

        # Return to the page of products
        return render_template("products.html", categories = cat,
        country=countryid, products = products)
    except:
        return "<script>window.location = '/products'; alert('Product does not exist');</script>"
        


# ---------------------------- ADD PRODUCT TO SHOPPING CART ROUTE ----------------------------
@views.route('/addProd', methods=['GET', 'POST'])
def addProd():
    global cart

    countryid = request.cookies.get('country')

    # Get the product id
    prodId = request.args.get('productId')

    # Get the info of the product
    q1 = 'EXEC ReadProduct @inProductId =' + str(prodId) +\
    ',@visibleId =' + str(request.cookies.get('isSuscribed'))
    cursorProd.execute(q1)
    
    # Encode the images of the products
    for product in cursorProd:
        product.productImage = b64encode(product.productImage).decode("utf-8")
        cart.append(product)
    
    # Get the total price
    total = 0
    for i in cart:
        total += i.price
    
    # Get list of producs + quantity
    quantList = []
    for i in cart:
        quantList.append([i.idProduct,1])

    return render_template("shopcar.html", total = total,
    country=request.cookies.get('country'), user=request.cookies.get('user'), 
    cart = cart,quantList = json.dumps(quantList))

# ---------------------------- SHOPPING CART ROUTE ----------------------------
@views.route('/shopcar', methods=['GET', 'POST'])
def shopcar():
    
    # Get the total price
    total = 0
    for i in cart:
        total += i.price
    
    # Get list of producs + quantity
    quantList = []
    for i in cart:
        quantList.append([i.idProduct,1])
    
    return render_template("shopcar.html", 
    country=request.cookies.get('country'), total = total,
    user=request.cookies.get('user'), cart = cart, quantList = json.dumps(quantList))

# ---------------------------- CHECKOUT ROUTES ----------------------------

# --- Route that makes the purchase ---
@views.route('/purchase', methods=['GET', 'POST'])
def purchase():

    # Get the saved locations of the user
    q1 = 'EXEC GetUserLocations @inidUserxPlace =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(q1)
    locations = []
    for i in cursorGen:
        locations.append(i)
    
    # Get the saved payment method of a user 
    q1 = 'EXEC GetUserPayment @inidUserxPlace =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(q1)
    payments = cursorGen.fetchval()
    if payments != None:
        lastDigits = 'Card ending in '
        lastDigits += str(payments%10000)
        cardString = lastDigits
    else:
        cardString = "No card"

    
    # Save in global variable
    global locationsG
    locationsG = locations

    global cardStringG
    cardStringG = cardString 

    # Save coordinates in global variable
    global coordinates
    x = request.args.get('X')
    y = request.args.get('Y')
    coordinates.append(x)
    coordinates.append(y)

    # Get the option selected 
    locationOption = request.args.get('LocationOption')
    
    # Get the info about the location
    locationName = request.args.get('LocationName')
    LocationSavedId = request.args.get('LocationSavedId')
    
    # --------- User decided to use new location ---------
    if (locationOption == 'true'):
        
        # Did the user gave a name to the location? If so, save it
        if(locationName != ''):
            
            # Save the location
            q1 = 'EXEC AddLocation @inidUserxPlace =' + str(request.cookies.get('idUserXplace')) + \
            ', @locationName = ' + str(locationName) + ',@locationX =' + str(x) + ',@locationY =' + str(y) 
            cursorGen.execute(q1)

        # If user didnt want to save it, do nothing
    
    # --------- User decided to use saved location ---------
    else:

        # Get coordinates from the saved location
        q2 = 'EXEC GetCoordinates  @inidUserxPlace =' + str(request.cookies.get('idUserXplace')) + \
        ', @inLocationName = ' + str(LocationSavedId)
        
        cursorGen.execute(q2)
        newCoord = []
        for i in cursorGen:
            newCoord.append(i)

        # Get X and Y coordinates according to the id 
        coordinates[0] = newCoord[0][0]
        coordinates[1] = newCoord[0][1]
    
    # Determine if the user decided to use new payment or a saved one
    paymentOption = request.args.get('paymentOption')

    # --------- User decided to use new payment ---------
    if (paymentOption == 'True'):
        
        # Get the data
        PaymenType = request.args.get('PaymenType')
        CardName = request.args.get('paymentName')
        Accountnumber = request.args.get('paymentnumber')
        Expdate = request.args.get('paymentdate')
        cvv = request.args.get('paymentcvv')
        
        # Modify payment info
        q3 = 'EXEC ModifyPayment @inidUserxPlace = ' + str(request.cookies.get('idUserXplace')) + \
        ', @inNameOnCard = ' + "'" + str(CardName) + "'" + ', @inAccountNumber = ' + str(Accountnumber) + \
        ', @inExpirationDate = ' + "'" + str(Expdate) + "'" + ', @inCVV = ' + str(cvv) 
        cursorGen.execute(q3)

    # --------- User decided to use saved payment ---------
    else:
        cardId = request.args.get('paymentsavedCard')

    idsellers = [1, 2, 7, 8, 13, 14]
    iddelivers = [3, 4, 9, 10, 15, 16]
    
    # ------------------ PURCHASE ------------------
 
    for item in cartQuant:
        
        purchaseQuery = 'EXEC purchase' + \
        ' @productId =' + str(item[0]) + \
        ', @quantity =' + str(item[1]) + \
        ', @idUser =' + str(request.cookies.get('idUserXplace')) + \
        ', @idSeller =' + str(random.choice(idsellers)) + \
        ', @idDelieveryPerson =' + str(random.choice(iddelivers)) + \
        ', @locationName =' + "'" + str(LocationSavedId) + "'" + \
        ', @locationX =' + str(coordinates[0]) +  \
        ', @locationY =' +  str(coordinates[1])
        cursorSales.execute(purchaseQuery)

    # ------------------ INVOICE ------------------

    # Get the ids of the sales
    salesId = []
    for item in cartQuant:
        query = 'EXEC GetIdSale @productId =' + str(item[0]) +\
        ', @idUser=' + str(request.cookies.get('idUserXplace'))
        cursorSales.execute(query)
        idSale = cursorSales.fetchval()
        salesId.append(idSale)

    # Get invoice
    invoice  = []
    
    for sale in salesId:
        invoiceQuery = 'EXEC createInvoice @saleId=' + str(sale)
        cursorSales.execute(invoiceQuery)
        invoice.append(cursorSales.fetchall())

    total = 0
    stringInvoice = "-----------------INVOICE---------------\n"

    for item in invoice:
        stringInvoice += "-->" + str(item[0].Product_Name) + "\n"
        stringInvoice += "Price:" + str(item[0].Individual_Price) + "\n"
        stringInvoice += "Quantity:" + str(item[0].quantity) + "\n"
        total += item[0].total
    
    print(stringInvoice)
    
    # Get the email of the user
    query = 'EXEC getUsersMail @inIdUserXPlace =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(query)
    you = cursorGen.fetchval()
    print(you)

    # -------- send invoice --------
    me = "vchinchillam02@gmail.com"
    my_password = r"lxzmnxpuiwxahguk"

    msg = MIMEMultipart('alternative')
    msg['Subject'] = "Alert"
    msg['From'] = me
    msg['To'] = you

    # Send the message via gmail
    server = smtplib.SMTP_SSL('smtp.googlemail.com', 465)
    server.login(me, my_password)
    server.sendmail(me, you, stringInvoice)
    server.quit()

    return render_template("checkout.html", 
    country=request.cookies.get('country'), user=request.cookies.get('user'), 
    listQuant = cartQuant, x = x, y = y, 
    locations = locationsG, cardString = cardStringG)


# Route for location and payment method page
@views.route('/redcheckout', methods=['GET', 'POST'])
def redcheckout():
    global cartQuant
    
    # Get the list of quantities
    listQuant = request.args.get('listQuant')
    
    # Turn list into list of lists
    composite_list = listQuant.split(",")
    
    # Group by every 2 indexes in order to have [[idProduct, quantity], [idProduct, quantity], ...]
    newListQuant = [composite_list[x:x+2] for x in range(0, len(composite_list),2)]
    
    # Save in global variable
    cartQuant = newListQuant
    
    # Get the saved locations of the user
    q1 = 'EXEC GetUserLocations @inidUserxPlace =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(q1)
    locations = []
    for i in cursorGen:
        locations.append(i)
    
    # Get the saved payment method of a user 
    q1 = 'EXEC GetUserPayment @inidUserxPlace =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(q1)
    payments = cursorGen.fetchval()
    if payments != None:
        lastDigits = 'Card ending in '
        lastDigits += str(payments%10000)
        cardString = lastDigits
    else:
        cardString = "No card"
    
    # Save in global variable
    global locationsG
    locationsG = locations

    global cardStringG
    cardStringG = cardString 

    return render_template("checkout.html", 
    country=request.cookies.get('country'), user=request.cookies.get('user'), 
    listQuant = cartQuant, x = 53.344484804947356, y = -6.244354248046876, 
    locations = locationsG, cardString = cardStringG)

# Checkout
@views.route('/checkout', methods=['GET', 'POST'])
def checkout():
    return render_template("checkout.html", 
    country=request.cookies.get('country'), user=request.cookies.get('user'), 
    locations = locationsG, cardString = cardStringG)

# ---------------------------- SUSCRIPTIONS ROUTE ----------------------------

@views.route('/suscribe', methods=['GET', 'POST'])
def suscribe():

    # Get all the types of suscriptions
    query = 'EXEC readSuscriptions'
    cursorGen.execute(query)
    suscriptions = []
    for i in cursorGen:
        suscriptions.append(i)
    
    return render_template("suscribe.html", 
    country=request.cookies.get('country'), 
    user=request.cookies.get('user'), suscriptions = suscriptions)

# ---------------------------- BUY SUSCRIPTION ROUTE ----------------------------

@views.route('/Buysuscription', methods=['GET', 'POST'])
def Buysuscription():
    cardString = ''
    idUser = request.cookies.get('idUserXplace')
    usern = request.cookies.get('user')
    
    if request.method == 'GET':
        
        global Idsuscription
        suscriptionId = request.args.get('idSuscription')
        Idsuscription = suscriptionId
        
        # Determine if the user is logged in
        if usern != None and usern != '':

            # Get the payment methods of the user
            q1 = 'EXEC GetUserPayment @inidUserxPlace =' + str(idUser)
            cursorGen.execute(q1)
            payments = cursorGen.fetchval()
            if payments != None:
                lastDigits = 'Card ending in '
                lastDigits += str(payments%10000)
                cardString = lastDigits
            else:
                cardString = "No card"

            return render_template("Buysuscription.html", 
            country=request.cookies.get('country'), user=request.cookies.get('user'),
            card = cardString)

        # Not logged in
        else:
            flash('Please log in before', category="error")
            return render_template("login.html", country=request.cookies.get('country'))
    else:
        # Get data from the form
        suscriptionOption = request.form.get('suscriptionOption')
        
        # User decided to pay with new card
        if(suscriptionOption == '1'):

            # Get info of the form
            nameCard = request.form.get('Name')
                        
            # Name cant be number
            if nameCard.isdigit():
                flash('Name cant be a number', category="error")
                return render_template("Buysuscription.html", 
                country=request.cookies.get('country'), user=request.cookies.get('user'),
                card = cardString)
            else:
                # --------- Valid Name, check card number ---------
                Cardnumber = request.form.get('number')
                # Cardnumber cant be a string
                flag = Cardnumber.isdigit()
                if not flag:
                    flash('Card must be a number', category="error")
                    return render_template("Buysuscription.html", 
                    country=request.cookies.get('country'), user=request.cookies.get('user'),
                    card = cardString)
                else:
                    # --------- Valid Name, check date and cvv ---------
                    date = request.form.get('date')
                    cvv = request.form.get('cvv')
                    # CVV must be a numer
                    flag2 = cvv.isdigit()
                    if not flag2:
                        flash('CVV must be a number', category="error")
                        return render_template("Buysuscription.html", 
                        country=request.cookies.get('country'), user=request.cookies.get('user'),
                        card = cardString)
                    else:
                        # Modify User Card
                        q1 = 'EXEC ModifyPayment @inidUserxPlace =' + str(idUser) + \
                        ',@inNameOnCard =' + "'" + str(nameCard) + "'" + \
                        ',@inAccountNumber = ' + str(Cardnumber) + ',@inExpirationDate =' + "'" + \
                        str(date) + "'" + \
                        ',@inCVV  = ' + str(cvv)
                        
                        cursorGen.execute(q1)
                        result = cursorGen.fetchval()
                        
                        if (result == '1'):
                            # Suscribe the user
                            q2 = 'EXEC suscribeUser @inidUserxPlace =' + str(idUser) + \
                            ', @inSuscriptionId = '+ str(Idsuscription)
                            cursorGen.execute(q2)
                            
                            resp = redirect("http://127.0.0.1:5000/Buysuscription")
                            
                            
                            
                            flash('You are now suscribed, enjoy our perks!', category="success")
                            
                            resp = make_response(render_template("Buysuscription.html", 
                            country=request.cookies.get('country'), user=request.cookies.get('user'),
                            card = cardString))
                            
                            resp.set_cookie('isSuscribed', '1')
                            
                            return resp
                        else:
                            flash('Error when adding card', category="error")

                            return render_template("Buysuscription.html", 
                            country=request.cookies.get('country'), user=request.cookies.get('user'),
                            card = cardString)
        
        # User decided to use saved card
        else:

            # Suscribe user
            q2 = 'EXEC suscribeUser @inidUserxPlace =' + str(idUser) + \
            ', @inSuscriptionId = '+ str(Idsuscription)
            cursorGen.execute(q2)

            resp = redirect("http://127.0.0.1:5000/Buysuscription")
                            
            
                            
            flash('You are now suscribed, enjoy our perks!', category="success")
            
            resp = make_response(render_template("Buysuscription.html", 
            country=request.cookies.get('country'), user=request.cookies.get('user'),
            card = cardString))
            
            resp.set_cookie('isSuscribed', '1')
            
            return resp

# ---------------------------- PROFILE ROUTE ----------------------------

@views.route('/profile')
def profile():
    # Get the info of the user
    idUser = request.cookies.get('idUserXplace')
    usern = request.cookies.get('user')
    
    # Determine if the user is logged in
    if usern != None and usern != '':
        
        querystring = 'EXEC ReadProfile @inUserName =' + str(usern) + ', @inidUserxPlace = '  + str(idUser)
        cursorGen.execute(querystring)
        results = cursorGen.fetchone()
        
        # Determine if the query was able to succeded
        if (int(len(results)) > 1):
            
            # Get all the info 
            suscribed = results[2]
            email = results[3]
            name = results[4]
            surname = results[5]
            phone = results[6]
            country = results[7]
           
            if(country==1):
                country = 'Ireland'
            if(country==2):
                country = 'Scotland'
            if(country==3):
                country = 'United States'
            
            # Get the name of the suscription
            q2 = 'EXEC ReadSuscripName @inidUserxPlace =' + str(idUser)
            cursorGen.execute(q2)
            nameS = cursorGen.fetchval()

            # Set cookie if the user is suscribed
            if(nameS == 'None'):
                
                resp = make_response(render_template("profile.html", country=request.cookies.get('country'), 
                user=request.cookies.get('user'), password = request.cookies.get('password'),
                idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
                email = email, name = name,countryUser = country,
                surname = surname, phone = phone))
                
                resp.set_cookie('isSuscribed', '0')
                
                return resp
            else:
                
                resp = make_response(render_template("profile.html", country=request.cookies.get('country'), 
                user=request.cookies.get('user'), password = request.cookies.get('password'),
                idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
                email = email, name = name, countryUser = country,
                surname = surname, phone = phone))
                
                resp.set_cookie('isSuscribed', '1')
                
                return resp
        # Query didnt succed
        else:
            # Flash error
            flash('User does not exist', category="error")
            
            return render_template("profile.html", country=request.cookies.get('country'), 
            user=request.cookies.get('user'), password = request.cookies.get('password'),
            idUserXplace=request.cookies.get('idUserXplace'))
    # Not logged in
    else:
        flash('Please log in before', category="error")
        return render_template("login.html", country=request.cookies.get('country'))

# ---------------------------- EDIT PROFILE ROUTE ----------------------------

@views.route('/editProf', methods = ['POST', 'GET'])
def editProf(): 

    # Get the info of the user
    idUser = request.cookies.get('idUserXplace')
    usern = request.cookies.get('user')

    # Get default info
    querystring = 'EXEC ReadProfile @inUserName =' + str(usern) + ', @inidUserxPlace = '  + str(idUser)
    cursorGen.execute(querystring)
    results = cursorGen.fetchone()
    
    # Determine if the query was able to succeded
    if (int(len(results)) > 1):
        
        # Get all the info 
        suscribed = results[2]
        email = results[3]
        name = results[4]
        surname = results[5]
        phone = results[6]
        country = results[7]
        
        if(country==1):
            country = 'Ireland'
        if(country==2):
            country = 'Scotland'
        if(country==3):
            country = 'United States'
        
        # Get the name of the suscription
        q2 = 'EXEC ReadSuscripName @inidUserxPlace =' + str(idUser)
        cursorGen.execute(q2)
        nameS = cursorGen.fetchval()


    # Get the info from the form
    userE = request.form.get('userE')
    if userE != '':
        
        passE = request.form.get('passE')
        if passE != '':
            
            # Determine if the password has uppercases
            response = False
            for character in passE:
                # checking for uppercase character and flagging
                if character.isupper():
                    response = True
                    break
            
            # Determine if the password contains numbers
            numbers = (passE.isalnum()) and (not passE.isalpha()) and (not passE.isnumeric())
            
            # Determine if the password is safe
            if len(passE)  > 8 and response == True and numbers == True:

                emailE = request.form.get('emailE')
                flagEmail = '@' in emailE
                if flagEmail:
                    
                    # Get the rest of the info
                    nameE = request.form.get('nameE')
                    surnameE = request.form.get('surnameE')
                    phoneE = request.form.get('phoneE')
                    flagPhone = phoneE.isdigit()
                    
                    if flagPhone:
                        idUserX = request.cookies.get('idUserXplace')
                        
                        query = 'EXEC ModifyProfile @inUserName =' + str(userE) + ',@inPassword =' + str(passE) + \
                        ',@inEmail  = ' + "' "+ str(emailE)+ "' "+ ',@inName  = ' + str(nameE) + ',@inSurname  = ' + "' "+ str(surnameE) + "' " +\
                        ',@inPhone =' + str(phoneE) + ',@inidUserxPlace = ' + str(idUserX) 
                        
                        cursorGen.execute(query)
                        resp = redirect("http://127.0.0.1:5000/profile")
                        
                        return resp

                    else:

                        flash('Phone must be a number', category="error")

                        return render_template("profile.html", country=request.cookies.get('country'), 
                        user=request.cookies.get('user'), password = request.cookies.get('password'),
                        idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
                        email = email, name = name, countryUser = country,
                        surname = surname, phone = phone)
                else:

                    flash('Incorrect syntax for email, make sure to use @', category="error")

                    return render_template("profile.html", country=request.cookies.get('country'), 
                    user=request.cookies.get('user'), password = request.cookies.get('password'),
                    idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
                    email = email, name = name, countryUser = country,
                    surname = surname, phone = phone)
            else:

                flash('Password must be 8 characters long, have numbers, letters and uppercases', category="error")

                return render_template("profile.html", country=request.cookies.get('country'), 
                user=request.cookies.get('user'), password = request.cookies.get('password'),
                idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
                email = email, name = name, countryUser = country,
                surname = surname, phone = phone)
        else:

            flash('You must fill the password', category="error")
            return render_template("profile.html", country=request.cookies.get('country'), 
            user=request.cookies.get('user'), password = request.cookies.get('password'),
            idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
            email = email, name = name, countryUser = country,
            surname = surname, phone = phone)

    else:

        flash('You must fill the username', category="error")

        return render_template("profile.html", country=request.cookies.get('country'), 
        user=request.cookies.get('user'), password = request.cookies.get('password'),
        idUserXplace=request.cookies.get('idUserXplace'), suscription = nameS,
        email = email, name = name, countryUser = country,
        surname = surname, phone = phone)




# ---------------------------- ORDERS ROUTE ----------------------------

# ---------- Get orders ----------
@views.route('/orders', methods=['GET', 'POST'])
def orders():

    # Get the info of the user
    idUser = request.cookies.get('idUserXplace')
    usern = request.cookies.get('user')
    
    # Determine if the user is logged in
    if usern != None and usern != '':

        # Get the orders of the user
        q1 = 'EXEC GetUserPurchases @idUser = ' + str(request.cookies.get('idUserXplace'))
        cursorSales.execute(q1)

        orders = []
        for order in cursorSales:
            order.productImage = b64encode(order.productImage).decode("utf-8")
            orders.append(order)

        global ordersG
        ordersG = orders

        return render_template("orders.html", country=request.cookies.get('country'), orders = orders)
    # Not logged in
    else:
        flash('Please log in before', category="error")
        return render_template("login.html", country=request.cookies.get('country'))

# ---------- Make review and evaluation of 1 order ----------
@views.route('/makeRevEvOrder', methods=['GET', 'POST'])
def makeRevEvOrder():

    # Get the button id
    button = request.args.get('buttonId')
    
    # Get the info of the selected product
    idOrder = int(button)-1
    
    order = ordersG[idOrder]

    # Get the evaluations of the user
    query1 = 'EXEC GetUserEvaluations @idUser=' + str(request.cookies.get('idUserXplace')) +\
    ', @idProduct =' + str(order.idProduct)
    cursorGen.execute(query1)

    evaluations = []
    evaluationsIds = []
    for evaluation in cursorGen:
        evaluationsIds.append(evaluation.idEvaluation)
        evaluations.append(evaluation)

    quantityEvals = len(evaluations)

    # Get responses to those evaluations
    responses = []
    for evaluation in evaluationsIds:
        print(evaluation)
        # Get the answers of these evaluation        
        query2 = 'exec GetUserResponsesEv @evaluationId=' + str(evaluation) + \
        ', @idUser =' + str(request.cookies.get('idUserXplace'))
        cursorGen.execute(query2)

        # Save the answers of these evaluation 
        for response in cursorGen:
            responses.append(response)
    
    quantityAnsw = len(responses)
    return render_template("order.html", country=request.cookies.get('country'), 
    order = order, idOrder = idOrder + 1, evaluations = evaluations, 
    quantityEvals = quantityEvals, answers = responses, quantityAnsw = quantityAnsw)

# --------- Add review --------
@views.route('/addReview', methods=['GET', 'POST'])
def addReview():

    # Get the info of the new review
    reviewMessage = request.args.get('reviewMessage')
    idProduct = request.args.get('idProduct')
    idUser = request.cookies.get('idUserXplace')

    # Add review
    q1 = 'EXEC AddReview @idProduct =' + str(idProduct) + \
    ',@idUser =' + str(idUser) + ',@comment =' + "'" + str(reviewMessage) + "'"
    cursorGen.execute(q1)

    # Get products and their info
    querystring = 'EXEC ReadProducts @visibleId =' + str(request.cookies.get('isSuscribed'))
    cursorProd.execute(querystring)
    products = []
    
    # Encode the images of the products
    for product in cursorProd:
        product.productImage = b64encode(product.productImage).decode("utf-8")
        products.append(product)
    
    # Save in global variable
    global productsG
    productsG = products
    
    # Get the names of the categories for the sidebar
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    categories = cursorProd.fetchall()

    # Save in global variable
    global categoriesG
    categoriesG = categories

    return render_template("products.html", categories = categoriesG,
    country=request.cookies.get('country'), products = products)

# --------- Add evaluation --------

@views.route('/addEvaluation', methods=['GET', 'POST'])
def addEvaluation():

    # Get the info of the new evaluation
    evaluationMessage = request.args.get('evaluationMessage')
    idProduct = request.args.get('idProduct')
    idUser = request.cookies.get('idUserXplace')
    idOrder =  request.args.get('idOrder')
    idDeliever =  request.args.get('idDeliever')
    idSeller =  request.args.get('idSeller')
    Calification =  request.args.get('Calification')

    # Add evaluation
    query = 'EXEC AddEvaluation @idProduct =' + str(idProduct) + \
    ', @idUser = ' + str(idUser) + ',@idDeliever =' + str(idDeliever) +\
    ', @idSeller = ' + str(idSeller) + ', @calification =' + str(Calification) +\
    ', @comment =' + "'" + str(evaluationMessage) + "'"
    cursorGen.execute(query)

    # Redirect
    order = ordersG[int(idOrder)-1]

        # Get the evaluations of the user
    query1 = 'EXEC GetUserEvaluations @idUser=' + str(request.cookies.get('idUserXplace')) +\
    ', @idProduct =' + str(order.idProduct)
    cursorGen.execute(query1)

    evaluations = []
    evaluationsIds = []
    for evaluation in cursorGen:
        evaluationsIds.append(evaluation.idEvaluation)
        evaluations.append(evaluation)

    quantityEvals = len(evaluations)
    return render_template("order.html", country=request.cookies.get('country'), 
    order = order, idOrder = idOrder, evaluations = evaluations, 
    quantityEvals = quantityEvals)


# ---------------------------- ADMIN ROUTE ----------------------------

@views.route('/admin', methods=['GET', 'POST'])
def admin():

    # Get the info of the user
    idUser = request.cookies.get('idUserXplace')
    usern = request.cookies.get('user')
    
    # Determine if the user is logged in
    if usern != None and usern != '':

        # Determine if the user is an admin 
        q2 = 'EXEC determineAdmin @inUserXPlace =' + str(idUser)
        cursorGen.execute(q2)
        UserisAdmin = cursorGen.fetchval()

        # If the user is admin they can view the page
        if(UserisAdmin == '1'):
            
            # Get products and their info
            querystring = 'EXEC ReadProducts @visibleId =' + str(request.cookies.get('isSuscribed'))
            cursorProd.execute(querystring)
            products = []
            
            # Encode the images of the products
            for product in cursorProd:
                product.productImage = b64encode(product.productImage).decode("utf-8")
                products.append(product)
            
            # Save in global variable
            global productsG
            productsG = products

            # Get the categories 
            query2 = 'EXEC GetCategoriesProducts;'
            cursorProd.execute(query2)
            cat = cursorProd.fetchall()
          
            resp = make_response(render_template("admin.html", 
            country=request.cookies.get('country'), user=request.cookies.get('user'), categories = cat))
            
            resp.set_cookie('isSuscribed', '1')
            
            return resp

        else:
            flash('You are not an admin, try loggin in with your admin account', category="error")
            return render_template("login.html", country=request.cookies.get('country'))
    # Not logged in
    else:
        flash('Please log in before', category="error")
        return render_template("login.html", country=request.cookies.get('country'))


    
# ---------------------------- ADMIN PRODUCTS ----------------------------

# -------- Add new type --------
@views.route('/addTypeProd', methods=['GET', 'POST'])
def addTypeProd():
    Name = request.form.get('Name')
    if Name.isdigit():
        flash('Name of product invalid', category="error")
        return render_template("adminProd.html", products = productsG)
    else:
        query2 = 'EXEC AddProductType @inname =' + "'" + str(Name) + "'"
        cursorProd.execute(query2)

        # Get the categories 
        query3 = 'EXEC GetCategoriesProducts;'
        cursorProd.execute(query3)
        cat = cursorProd.fetchall()

        flash('Type Added', category="success")
        return render_template("adminProd.html", products = productsG,
        categories = cat)


# -------- Modify type --------
@views.route('/modifyTypeProd', methods=['GET', 'POST'])
def modifyTypeProd():
    category = request.form.get('category')
    NewName = request.form.get('NewName')
    if NewName.isdigit():
        flash('Name of product invalid', category="error")
        return render_template("adminProd.html", products = productsG)
    else:
        # Modify the type
        query = 'EXEC modifyProductType @inIdProduct =' + str(category) + \
        ', @inNewName =' + "'" + str(NewName) + "'"
        cursorProd.execute(query)

        # Get the categories 
        query3 = 'EXEC GetCategoriesProducts;'
        cursorProd.execute(query3)
        cat = cursorProd.fetchall()

        flash('Type Deleted', category="success")
        return render_template("adminProd.html", products = productsG,
        categories = cat)


# -------- Delete type --------
@views.route('/deleteTypeProd', methods=['GET', 'POST'])
def deleteTypeProd():
    category = request.form.get('category')
    
    # Delete the category
    query1 = 'EXEC deleteProductType @typeProductId =' + str(category)
    cursorProd.execute(query1)

    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    flash('Type Deleted0', category="success")
    return render_template("adminProd.html", products = productsG,
    categories = cat)


# -------- Add new product --------
@views.route('/addNewProd', methods=['GET', 'POST'])
def addNewProd():
    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    # Get the info of the form
    Name = request.form.get('Name')
    flagName = Name.isdigit()
    if not flagName:
        
        Price = float(request.form.get('Price'))
        
        Flavour = request.form.get('Flavour')
        flagFlavour = Flavour.isdigit()
        
        if not flagFlavour:
            
            Year = request.form.get('Year')
            flagYear = Year.isdigit()
            
            if flagYear:
                
                Size = request.form.get('Size')
                flagSize = Size.isdigit()
                
                if flagSize:
                    
                    Description = request.form.get('Description')
                    quantity = request.form.get('Quantity')
                    visible = request.form.get('visible')
                    category = request.form.get('category')
                    Country = request.form.get('country')
                    image = request.form.get('image')

                    # Default route
                    image = 'C:/Images/' + image
                    
                    # Insert product

                    query = 'EXEC CreateProduct @quantity =' + str(quantity) +\
                    ', @idCoin = ' + str(Country) + \
                    ',@idProctType =' + str(category) + \
                    ',@name = ' + "'"+ str(Name) + "'"+ \
                    ',@price =' + str(Price) +\
                    ',@visible = ' + str(visible) + \
                    ',@flavour =' + "'"+ str(Flavour) + "'"+ \
                    ',@year = ' + str(int(Year)) +\
                    ',@size = ' + str(int(Size)) +  \
                    ',@description = ' + "'"+ str(Description) + "'"+ \
                    ',@productImage =' + "'"+ str(image) + "'"
                    
                    cursorProd.execute(query)
                    string = "A new product was added to our page! Visit now to get more info\n-------PRODUCT INFO-----"
                    string += "Name: " + str(Name)
                    string += "Price: " + str(Price)
                    string += "Flavour: " + str(Flavour)
                    string += "Year: " + str(Year)
                    string += "Description: " + str(Description)

                    
                    # -------- send email to suscribers --------
                    
                    # Get emails in a list
                    
                    query2 = 'EXEC getUsersMails'
                    cursorGen.execute(query2)
                    emails = []
                    for email in cursorGen:
                        emails.append(email)

                    me = "vchinchillam02@gmail.com"
                    my_password = r"lxzmnxpuiwxahguk"

                    for person in emails:
                        you = person[0]
                        print(you)
                        msg = MIMEMultipart('alternative')
                        msg['Subject'] = "Alert"
                        msg['From'] = me
                        msg['To'] = you

                        # Send the message via gmail
                        server = smtplib.SMTP_SSL('smtp.googlemail.com', 465)
                        server.login(me, my_password)
                        server.sendmail(me, you, string)
                        server.quit()

                    return render_template("admin.html", 
                    country=request.cookies.get('country'), 
                    user=request.cookies.get('user'), 
                    categories = cat)
                else:
                    flash('Size must be a number', category="error")
                    return render_template("adminProd.html", 
                    products = productsG, categories = cat)
            else:
                flash('Year must be a number', category="error")
                return render_template("adminProd.html", 
                products = productsG, categories = cat)
        else:
            flash('Flavour must be a string', category="error")
            return render_template("adminProd.html", 
            products = productsG, categories = cat)
        
    else:
        flash('Name must be a string', category="error")
        return render_template("adminProd.html", 
        products = productsG, categories = cat)

# -------- Modify product --------
@views.route('/modifyProd', methods=['GET', 'POST'])
def modifyProd():

    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    # Get the info of the form
    Name = request.form.get('Name')
    flagName = Name.isdigit()
    if not flagName:
        
        Price = request.form.get('Price')
 
        Flavour = request.form.get('Flavour')
        flagFlavour = Flavour.isdigit()
        
        if not flagFlavour:
            
            Year = request.form.get('Year')
            flagYear = Year.isdigit()
            
            if flagYear:
                
                Size = request.form.get('Size')
                flagSize = Size.isdigit()
                
                if flagSize:
                    
                    Description = request.form.get('Description')
                    visible = request.form.get('visible')
                    category = request.form.get('category')
                    Country = request.form.get('country')
                    image = request.form.get('image')

                    # Default route
                    image = 'C:/Images/' + image
                    
                    # Modify product
                    # Get the id
                    idproduct = request.form.get('product')
                    
                    query = 'EXEC UpdateProduct @idProduct = ' + str(idproduct) + \
                    ',@idCoin = ' + str(Country) + \
                    ',@idProctType =' + str(category) + \
                    ',@name = ' + "'"+ str(Name) + "'"+ \
                    ',@price =' + str(Price) +\
                    ',@visible = ' + str(visible) + \
                    ',@flavour =' + "'"+ str(Flavour) + "'"+ \
                    ',@year = ' + str(int(Year)) +\
                    ',@size = ' + str(int(Size)) +  \
                    ',@description = ' + "'"+ str(Description) + "'"+ \
                    ',@productImage =' + "'"+ str(image) + "'"
                    
                    cursorProd.execute(query)
                    
                    return render_template("admin.html", 
                    country=request.cookies.get('country'), 
                    user=request.cookies.get('user'), 
                    categories = cat)
                else:
                    flash('Size must be a number', category="error")
                    return render_template("adminProd.html", products = productsG)
            else:
                flash('Year must be a number', category="error")
                return render_template("adminProd.html", products = productsG)
        else:
            flash('Flavour must be a string', category="error")
            return render_template("adminProd.html", products = productsG)
    else:
        flash('Name must be a string', category="error")
        return render_template("adminProd.html", products = productsG)

# -------- Delete product --------
@views.route('/deleteProd', methods=['GET', 'POST'])
def deleteProd():

    # Get the product
    idproduct = request.form.get('product')
    
    # Delete the product
    query = 'EXEC deleteProduct @idProduct =' + str(idproduct)
    cursorProd.execute(query)

    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    flash('Product Deleted', category="success")
    return render_template("adminProd.html", products = productsG,
    categories = cat)


# -------- Admin product default --------
@views.route('/adminProd', methods=['GET', 'POST'])
def adminProd():
    
    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    # Get products and their info
    querystring = 'EXEC ReadProducts @visibleId =' + str(request.cookies.get('isSuscribed'))
    cursorProd.execute(querystring)
    products = []
    
    # Encode the images of the products
    for product in cursorProd:
        product.productImage = b64encode(product.productImage).decode("utf-8")
        products.append(product)
    
    # Save in global variable
    global productsG
    productsG = products

    return render_template("adminProd.html", 
    country=request.cookies.get('country'), 
    user=request.cookies.get('user'),
    categories = cat, products = productsG)

# ----------------------------PRODUCTS REPORT---------------------------------- 
@views.route('/reportProd', methods=['GET', 'POST'])
def reportProd():
    
    # Get the categories 
    query2 = 'EXEC GetCategoriesProducts;'
    cursorProd.execute(query2)
    cat = cursorProd.fetchall()

    # Get products and their info
    querystring = 'EXEC ReadProducts @visibleId =' + str(request.cookies.get('isSuscribed'))
    cursorProd.execute(querystring)
    products = []
    
    # Encode the images of the products
    for product in cursorProd:
        product.productImage = b64encode(product.productImage).decode("utf-8")
        products.append(product)
    
    # Save in global variable
    global productsG
    productsG = products

    # Get the info of the form
    Inventory = request.form.get('Inventory')
    InventoryChBox = request.form.get('InventoryChBox')

    Sales = request.form.get('Sales')
    SalesChBox = request.form.get('SalesChBox')

    category = request.form.get('category')
    TypeChBox = request.form.get('TypeChBox')

    country = request.form.get('country')
    CountryChBox = request.form.get('CountryChBox')

    Year = request.form.get('Year')
    YearChBox = request.form.get('YearChBox')

    # Set null values to those that were not checked
    if(InventoryChBox == None):
        Inventory = None
    if(SalesChBox == None):
        Sales = None
    if(TypeChBox == None):
        category = None
    if(CountryChBox == None):
        country = None
    if(YearChBox == None):
        Year = None
    
    cursorProd.execute("EXEC productsReport @in_type=?, @countryId=?, @quantity =?,@sales =?, @year=?", 
    (category, country, Inventory, Sales, Year))
    cursorProd.commit()

    productsReport = []
    for product in cursorProd:
        productsReport.append(product)
    
    return render_template("adminProd.html", 
    country=request.cookies.get('country'), 
    user=request.cookies.get('user'),
    categories = cat, products = productsG, productsReport = productsReport)

# ---------------------------- ADMIN CALIFICATIONS ----------------------------

# -------- Get all evaluations --------
@views.route('/adminCalifications', methods=['GET', 'POST'])
def adminCalifications():

    # Get all the evaluations
    q1 = 'EXEC GetAllEvaluations'
    cursorGen.execute(q1)
    evaluations = []
    for i in cursorGen:
        evaluations.append(i)

    # Save in global variable
    global evaluationsG
    evaluationsG = evaluations

    quantityEv = len(evaluations)
    return render_template("adminCalifications.html",
    evaluations = evaluations, quantityEv = quantityEv,
    country = request.cookies.get('country'))

# -------- Get 1 evaluation --------
@views.route('/evaluation', methods=['GET'])
def evaluation():
    
    # Get the button id
    idEvaluation = request.args.get('evalId')

    # Get the info of the selected evaluation
    idEvalIndex = int(idEvaluation)-1

    evaluation = evaluationsG[idEvalIndex]
    
    # Get the responses to the evaluation
    q1 = 'EXEC ReadResponseEV @evaluationId =' + str(evaluation.idEvaluation)
    cursorGen.execute(q1)
    answers = []
    for i in cursorGen:
        answers.append(i)
    

    # Determine if the user is a supervisor
    query2 = 'EXEC determineSupervisor @idUser =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(query2)
    userisSupervisor = cursorGen.fetchall()
    userisSupervisor = userisSupervisor[0][0]
    

    return render_template("evaluation.html", eval = evaluation, 
    answers = answers, idEvaluation = idEvaluation, 
    userisSupervisor = userisSupervisor, country = request.cookies.get('country'))

# -------- Add response to evaluatio --------
@views.route('/answer', methods=['GET', 'POST'])
def answer():
    
    # Get the id of the evaluation
    idEvaluation = request.args.get('evalId')

    # Get the info of the selected evaluation
    idEvalIndex = int(idEvaluation)-1
    evaluation = evaluationsG[idEvalIndex]
    
    comment = request.args.get('comment')
    idUser = request.args.get('idUser')
    
    # Add new response to evaluation
    q1 = 'EXEC AddResponse @idEvaluation =' + str(evaluation.idEvaluation) + \
    ',@idEmployee =' + str(request.cookies.get('idUserXplace')) + \
    ',@idUser =' + str(idUser) + \
    ',@description =' + "'" +  str(comment) + "'"
    print(q1)
    cursorGen.execute(q1)

    # Get the responses to the evaluation
    q2 = 'EXEC ReadResponseEV @evaluationId =' + str(evaluation.idEvaluation)
    cursorGen.execute(q2)
    answers = []
    for i in cursorGen:
        answers.append(i)

    # Determine if the user is a supervisor
    query2 = 'EXEC determineSupervisor @idUser =' + str(request.cookies.get('idUserXplace'))
    cursorGen.execute(query2)
    userisSupervisor = cursorGen.fetchall()
    userisSupervisor = userisSupervisor[0][0]

    return render_template("evaluation.html", eval = evaluation, userisSupervisor = userisSupervisor,
    answers = answers, country = request.cookies.get('country'))

# ---------------------------- ADMIN STORES ----------------------------
@views.route('/adminStores', methods=['GET', 'POST'])
def adminStores():
    return render_template("adminStores.html")


@views.route('/modifyStore', methods=['GET', 'POST'])
def modifyStore():
    
    # Get the info from the store and the coordinates
    x = request.args.get('X')
    y = request.args.get('Y')
    storeId = request.args.get('storeId')
    
    # Modify the location
    q1 = 'EXEC modifyStoreLocation @idStore =' + str(storeId) + \
    ', @locationX =' + str(x) + ', @locationY =' + str(y)
    cursorGen.execute(q1)
    
    return render_template("adminStores.html")


# ---------------------------- LOG OUT ROUTE ----------------------------

@views.route('/logout')
def logout():
    # Set all global variables empty
    cart = []
    categoriesG = []
    Idsuscription = 0
    cartQuant = []
    coordinates = []
    locationsG = []
    cardStringG = ''
    evaluationsG = []
    ordersG = []

    resp = redirect("http://127.0.0.1:5000/login")
    # Set cookies to nothing
    resp.set_cookie('user', '')
    resp.set_cookie('password', '')
    resp.set_cookie('isSuscribed', '0')
    flash('Signed out!', category="success")
    return resp