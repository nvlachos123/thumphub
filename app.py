from flask import Flask, render_template, request, redirect, url_for, session, flash 

import sqlite3

app = Flask(__name__)
app.secret_key = 'development-secret-key' # change for production

# Database connection function
def get_db_connection():
    conn = sqlite3.connect('database/thumphub.db')
    conn.row_factory = sqlite3.Row
    return conn

                    # ROUTES
# Each route is a function and is associated with a template

# Home
@app.route('/')
def index():
    return render_template('index.html')

# Login
@app.route('/login', methods=['GET', 'POST'])
def login():
    # If the user is already logged in, redirect them to the home page
    if 'user_id' in session:
        return redirect(url_for('index'))
    
    # If the request method is POST, check the email and password
    if request.method == 'POST':
        # Set up variables
        email = request.form['email']
        password = request.form['password']

        # Make a connection to the database
        conn = get_db_connection()

        # Query the database
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM Users WHERE email = ? AND password_hash = ?', (email, password))
        
        # For one user
        user = cursor.fetchone()

        # And close the connection
        conn.close()

        # If the user exists, log them in:
            # - set the user_id in the session
            # - flash success message 
            # - redirect to the home page
        if user:
            session['user_id'] = user['user_id']
            flash('Login successful!', 'success')
            return redirect(url_for('index'))
        
        # else, flash error message
        else:
            flash('Invalid email or password', 'error')
    # and return the login page
    return render_template('login.html')

# Register
@app.route('/register', methods=['GET', 'POST'])
def register():
    # If the user is already logged in, redirect them to the home page
    if 'user_id' in session:
        return redirect(url_for('index'))

    # If the request method is POST, check the email and password
    if request.method == 'POST':
        # Set up variables
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']

        # Make a connection to the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Query the database, try/catch
        try:
            # Insert the user
            cursor.execute(
                'INSERT INTO Users (username, email, password_hash) VALUES (?, ?, ?)',
                (username, email, password)
            )
            conn.commit()
            # Close the connection and flash success message
            flash('Registration successful! Please log in.', 'success')
            return redirect(url_for('login'))
        
        # if the username or email already exists
        except sqlite3.IntegrityError:
            # Close the connection and flash error message
            conn.rollback()
            flash('Username or email already exists', 'error')
        
        # Close the connection
        finally:
            conn.close()

    # Return the register page
    return render_template('register.html')

# Products
@app.route('/products')
def products():
    return render_template('products.html')

# Cart
@app.route('/cart')
def cart():
    return render_template('cart.html')

# Checkout
@app.route('/checkout')
def checkout():
    return render_template('checkout.html')

# Run the app with debug mode, host as 0.0.0.0 and port 5001 (for development)
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)