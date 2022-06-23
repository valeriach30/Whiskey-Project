from urllib import response
from flask import Blueprint, render_template, request, redirect, flash
import pyodbc
auth  = Blueprint('auth', __name__)

# ---- CONNECTION TO GENERAL DB ----
conGen = pyodbc.connect('Driver={SQL Server};Server=LAPTOP-4PEQIPMJ;Database=GeneralDB;', autocommit=True)
cursorGen = conGen.cursor() 


# ---------------------------- LOG IN ROUTE ----------------------------

@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        
        # Get user and password
        user = request.form.get('user')
        
        if user != '':

            passw = request.form.get('pass')
            if passw != '':
                # Determine if user is exists
                querystring = 'EXEC UserExists @inUserName = ' + str(user)
                cursorGen.execute(querystring)
                idUserXplace = cursorGen.fetchval()
                
                if idUserXplace == 0:
                    # User does not exist
                    flash('User does not exist, sign up now!', category="error")
                    return render_template("login.html", country=request.cookies.get('country'),
                    user=request.cookies.get('user'), password = request.cookies.get('password'),
                    idUserXplace=request.cookies.get('idUserXplace'))
                
                # User does exist
                else:
                    
                    # Determine if password is correct
                    querystring = 'EXEC PasswordCorrect @inUserName = ' + str(user) + ', @inPassword = ' + str(passw) + ', @inidUserxPlace = ' + str(idUserXplace) 
                    cursorGen.execute(querystring)
                    matched = cursorGen.fetchval()
                    
                    # Correct Password
                    if(matched == 1):
                        # Save user and password in cookies
                        resp = redirect("http://127.0.0.1:5000/login")
                        resp.set_cookie('user', user)
                        resp.set_cookie('password', passw)
                        
                        resp.set_cookie('idUserXplace', str(idUserXplace))

                        # Determine if the user is suscribed
                        q2 = 'EXEC ReadSuscripName @inidUserxPlace =' + str(idUserXplace)
                        cursorGen.execute(q2)
                        nameS = cursorGen.fetchval()

                        # Set cookie if the user is suscribed
                        if(nameS == 'None'):
                            resp.set_cookie('isSuscribed', '0')
                        else:
                            resp.set_cookie('isSuscribed', '1')
                            
                        flash('Signed in, welcome back!', category="success")
                        return resp
                    
                    # Incorrect password
                    else:
                        # Error
                        flash('Incorrect password, please try again', category="error")
                        
                        return render_template("login.html", country=request.cookies.get('country'), 
                        user=request.cookies.get('user'), password = request.cookies.get('password'),
                        idUserXplace=request.cookies.get('idUserXplace'))
            else:
                # Error
                flash('You must give a password', category="error")
                
                return render_template("login.html", country=request.cookies.get('country'), 
                user=request.cookies.get('user'), password = request.cookies.get('password'),
                idUserXplace=request.cookies.get('idUserXplace'))
        else:
            # Error
            flash('You must give a username', category="error")
            
            return render_template("login.html", country=request.cookies.get('country'), 
            user=request.cookies.get('user'), password = request.cookies.get('password'),
            idUserXplace=request.cookies.get('idUserXplace'))
    # Get method
    else:
        return render_template("login.html", country=request.cookies.get('country'), 
        user=request.cookies.get('user'), password = request.cookies.get('password'),
        idUserXplace=request.cookies.get('idUserXplace'))

# ---------------------------- SIGN UP ROUTE ----------------------------

@auth.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        
        # Get user and password
        NAME = request.form.get('NAME')
        if NAME != '':

            SURNAME = request.form.get('SURNAME')
            if SURNAME != '':
                EMAIL = request.form.get('EMAIL')

                flagEmail = '@' in EMAIL

                if flagEmail:
                    USERNAME = request.form.get('USERNAME')
                    if USERNAME != '':

                        PASSWORD = request.form.get('PASSWORD')
                        # Determine if the password has uppercases
                        response = False
                        for character in PASSWORD:
                            # checking for uppercase character and flagging
                            if character.isupper():
                                response = True
                                break
                        
                        # Determine if the password contains numbers
                        numbers = (PASSWORD.isalnum()) and (not PASSWORD.isalpha()) and (not PASSWORD.isnumeric())
                        
                        if PASSWORD != '' and response == True and numbers == True:
                            country = request.form.get('country')

                            # Add new user
                            query ='EXEC SignUpUser @idCode ='+ str(country) + \
                            ', @name = ' + "'" + str(NAME) + "'" + \
                            ', @surname='+ "'" + str(SURNAME) + "'" + \
                            ', @email=' + "'" + str(EMAIL) + "'" + \
                            ', @username= ' + "'" + str(USERNAME) + "'" + \
                            ', @password=' + "'" + str(PASSWORD) + "'" 

                            cursorGen.execute(query)

                            flash('User Created!', category="success")
                            return render_template("signup.html", country=request.cookies.get('country'))
                        else:
                            flash('Password must be 8 characters long, have numbers, letters and uppercases', category="error")
                            return render_template("signup.html", country=request.cookies.get('country'))
                    else:
                        flash('You must enter a username', category="error")
                        return render_template("signup.html", country=request.cookies.get('country'))
                else:
                    flash('Incorrect syntax for email, make sure to use @', category="error")
                    return render_template("signup.html", country=request.cookies.get('country'))
            else:
                flash('You must enter a surname', category="error")
                return render_template("signup.html", country=request.cookies.get('country'))
        else:
            flash('You must give a name', category="error")
            return render_template("signup.html", country=request.cookies.get('country'))
    else:
        return render_template("signup.html", country=request.cookies.get('country'))

# ---------------------------- HOME ROUTE ----------------------------

@auth.route('/home', methods=['GET', 'POST'])
def home():
    return render_template("home.html", country=request.cookies.get('country'))
