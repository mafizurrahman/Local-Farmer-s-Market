# Online Farmers Market 🌾

[![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://html.spec.whatwg.org/)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://www.w3.org/Style/CSS/)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

A dynamic e-commerce platform connecting local farmers with consumers, facilitating the direct sale of fresh produce through a user-friendly web interface.

## 🌟 Features

- **Dual User Roles:**
  - Farmer Portal for sellers
  - Buyer Portal for customers
- **Product Management:**
  - Product listing and categorization
  - Image upload functionality
  - Price management
- **User Authentication:**
  - Secure login/registration system
  - Role-based access control
- **Shopping Experience:**
  - Product search and filtering
  - Shopping cart functionality
  - Order management
- **Bidding System:**
  - Product auction management with detailed descriptions
  - Real-time bid tracking and history
  - Automated auction end-time management
  - Individual bid records with bidder information
  - Contact information for successful bidders
- **Visitor Management:**
  - Visitor registration and tracking
  - Purpose of visit documentation
  - Contact information management
  - Visitor analytics and reporting


## 🚀 Getting Started

### Prerequisites

- XAMPP (with PHP 7.4+ and MySQL)
- Web Browser (Chrome, Firefox, etc.)
- Git (optional)

### Installation

1. **Set up XAMPP**
   ```bash
   # Download and install XAMPP from
   https://www.apachefriends.org/download.html
   ```

2. **Clone/Download the Repository**
   ```bash
   git clone https://github.com/mafizurrahman/Local-Farmer-s-Market.git
   # Or download the ZIP file directly
   ```

3. **Project Setup**
   - Extract and copy the `V1_ofm` folder to:
     ```
     C:\xampp\htdocs\
     ```

4. **Database Configuration**
   - Start XAMPP Control Panel
   - Launch Apache and MySQL services
   - Open phpMyAdmin: http://localhost/phpmyadmin/
   - Create a new database named `impulse101`
   - Import `project.sql` from the `V1_ofm` folder

5. **Launch the Application**
   - Access the website: http://localhost/V1_ofm/ofm/
   - Create an account as either a buyer or farmer
   - Log in using your registered phone number and password

## 🏗️ Project Structure

```
V1_ofm/
├── Admin/              # Administrative interface
├── BuyerPortal/        # Buyer-specific features
├── FarmerPortal/       # Farmer-specific features
├── Functions/          # Core functionality
├── Includes/           # Shared components
├── Images/             # Asset storage
├── Demo_Images/        # Sample images
└── project.sql         # Database schema
```

## 💻 Technology Stack

- **Frontend:**
  - HTML5
  - CSS3
  - JavaScript
  - Bootstrap 4.x
- **Backend:**
  - PHP 7.4+
  - MySQL 5.7+
- **Server:**
  - Apache 2.4+

## 🌐 Application Routes

The application uses `index.php` as the main routing file, handling navigation between different sections:
- `/` - Homepage
- `/buyer` - Buyer portal
- `/farmer` - Farmer portal
- `/admin` - Administrative panel

## 🔒 Security Features

- Password hashing
- Session management
- Input validation
- SQL injection prevention
- XSS protection
