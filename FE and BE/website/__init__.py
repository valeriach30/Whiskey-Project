from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'RaDaVa2022'
    
    # Mail
    app.config['MAIL_SERVER']='smtp.mailtrap.io'
    app.config['MAIL_PORT'] = 2525
    app.config['MAIL_USERNAME'] = 'vchinchillam02@gmail.com'
    app.config['MAIL_PASSWORD'] = 'Rose2016'
    app.config['MAIL_USE_TLS'] = True
    app.config['MAIL_USE_SSL'] = False
    with app.app_context():
        # Import views
        from .views import views
        from .admin import admin
        from .auth import auth
        app.register_blueprint(views, url_prefix='/')
        app.register_blueprint(auth, url_prefix='/')
        app.register_blueprint(admin, url_prefix='/')

    return app