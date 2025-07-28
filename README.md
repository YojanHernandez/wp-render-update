# WordPress for Render - Production Only

WordPress optimized for Render with **automatic MySQL setup** and **production-ready configuration**.

## 📁 Structure

```
├── 📂 config/           # MySQL & supervisor configuration
├── 📂 scripts/          # Database setup script
├── Dockerfile          # Production container
└── README.md           # This file
```

## � **Deploy to Render**

### **Step 1: Create Web Service on Render**
1. Connect repository: `https://github.com/YojanHernandez/wp-render-update`
2. Environment: **Docker**
3. Auto-Deploy: **Enabled**

### **Step 2: Configure Environment Variables**

Add these variables to your Render web service:

#### **Required Environment Variables:**
```env
# Database Configuration
WORDPRESS_DB_HOST=localhost
WORDPRESS_DB_NAME=wordpress
WORDPRESS_DB_USER=wordpress
WORDPRESS_DB_PASSWORD=your_secure_password_here
MYSQL_ROOT_PASSWORD=your_secure_root_password_here

# WordPress Security Keys (Generate unique values!)
WORDPRESS_AUTH_KEY=your_unique_auth_key_here
WORDPRESS_SECURE_AUTH_KEY=your_unique_secure_auth_key_here
WORDPRESS_LOGGED_IN_KEY=your_unique_logged_in_key_here
WORDPRESS_NONCE_KEY=your_unique_nonce_key_here
WORDPRESS_AUTH_SALT=your_unique_auth_salt_here
WORDPRESS_SECURE_AUTH_SALT=your_unique_secure_auth_salt_here
WORDPRESS_LOGGED_IN_SALT=your_unique_logged_in_salt_here
WORDPRESS_NONCE_SALT=your_unique_nonce_salt_here

# Optional Configuration
WORDPRESS_TABLE_PREFIX=wp_
WORDPRESS_DEBUG=false
```

#### **Generate Secure Values:**
You can generate secure passwords and salts at:
- **Passwords**: Use any password generator (25+ characters recommended)
- **WordPress Salts**: https://api.wordpress.org/secret-key/1.1/salt/

### **Step 3: Deploy**
That's it! The container will automatically:
- ✅ Start MySQL server
- ✅ Create database using your environment variables
- ✅ Initialize WordPress
- ✅ Start Apache web server

## 🔧 **What Happens Automatically**

1. **MySQL Setup**: Database and user created from environment variables
2. **WordPress Configuration**: Automatic connection to database
3. **UTF8MB4 Support**: Full emoji and international character support
4. **Security**: Isolated database with minimal permissions

## 🎯 **Production Features**

- **Single Container**: Everything runs in one container
- **Persistent Storage**: Database stored on Render's persistent disk
- **Automatic Initialization**: No manual setup required
- **Security Optimized**: Minimal attack surface
- **Resource Efficient**: Optimized for Render's environment

## 🚀 **Quick Deploy Button**

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/YojanHernandez/wp-render-update)

## 📚 **Additional Resources**

- [Configure WordPress on Render](https://render.com/docs/deploy-wordpress)
- [Environment Variables on Render](https://render.com/docs/environment-variables)
- [Persistent Storage](https://render.com/docs/disks)

---

**Need Help?** Open an issue in the repository or check the official Render documentation.
