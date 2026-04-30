# 🚀 Deploying a Static Portfolio on AWS EC2 with Nginx

## 📌 Project Overview

This project demonstrates how I deployed a static portfolio website on AWS EC2 using Nginx as a web server.

This was not just deployment — it was a **deep dive into Linux, networking, permissions, and real-world debugging**.

---

## http://52.203.70.114 Link of deployed Numans-Portfolio

---

## 🧠 What I Learned

* How AWS EC2 works (Virtual Machines, Public & Private IPs)
* SSH authentication using key pairs (.pem)
* File transfer using SCP
* Linux file system structure (`/var/www`, `/home`, `/etc`)
* User permissions (`chown`, `chmod`)
* Nginx setup and configuration
* Debugging using logs (`/var/log/nginx/error.log`)
* Real-world problem solving (403 error, path issues)

---



## 🏗️ Architecture

User Browser → Internet → AWS EC2 → Nginx → Static Files

---

## ⚙️ Steps Performed

### 1. Launch EC2 Instance

* Ubuntu 22.04
* t2.micro
* Open ports:

  * 22 (SSH)
  * 80 (HTTP)
  * 443 (HTTPS)

---

### 2. Connect via SSH

```bash
ssh -i /Users/numan/Downloads/numan-cloud.pem ubuntu@52.203.70.114
```

---

### 3. Upload Files using SCP (FROM LOCAL MACHINE)

```bash
scp -i /Users/numan/Downloads/numan-cloud.pem -r /Users/numan/numan/projects/web/Numan-Portfolio/* ubuntu@52.203.70.114:/home/ubuntu/
```

---

### 4. Install Nginx

```bash
sudo apt update
sudo apt install nginx -y
```

---

### 5. Setup Web Directory

```bash
sudo mkdir -p /var/www/portfolio
sudo cp -r /home/ubuntu/portfolio-files/* /var/www/portfolio/
```

---

### 6. Set Permissions

```bash
sudo chown -R www-data:www-data /var/www/portfolio
sudo chmod -R 755 /var/www/portfolio
```

---

### 7. Configure Nginx

```bash
sudo nano /etc/nginx/sites-available/portfolio
```

Paste:

```nginx
server {
    listen 80;
    server_name <PUBLIC_IP>;
    root /var/www/portfolio;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

---

### 8. Enable Configuration

```bash
sudo ln -s /etc/nginx/sites-available/portfolio /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
```

---

### 9. Restart Nginx

```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

## 🐛 Problems Faced & Solutions

### ❌ Mistake 1: Running SCP inside server

* Issue: File transfer failed
* Fix: Run SCP from local machine

---

### ❌ Mistake 2: Folder inside folder issue

* Files were copied like:

```
/var/www/portfolio/Numan-Portfolio/index.html
```

* Nginx expected:

```
/var/www/portfolio/index.html
```

✅ Fix:

```bash
sudo cp -r /var/www/portfolio/Numan-Portfolio/* /var/www/portfolio/
```

---

### ❌ Mistake 3: Permission issues (403 Forbidden)

* Cause: Nginx couldn't read files

✅ Fix:

```bash
sudo chown -R www-data:www-data /var/www/portfolio
sudo chmod -R 755 /var/www/portfolio
```

---

## 🔍 Debugging Commands

```bash
sudo tail -20 /var/log/nginx/error.log
ls -la /var/www/portfolio/
sudo systemctl status nginx
sudo nginx -t
```

---

## 🧠 Key Takeaways

* Always know: Local vs Remote machine
* Always check logs instead of guessing
* Understand Linux permissions deeply
* Always use `/*` when copying folder contents
* Nginx runs as `www-data`

---

## 🚀 Final Result

✅ Successfully deployed a static portfolio website on AWS
✅ Understood complete flow from request → server → response
✅ Gained real-world debugging experience

---

## 📌 Next Improvements

* Add domain name (Route53)
* Enable HTTPS using SSL (Certbot)
* CI/CD using GitHub Actions
* Host using S3 + CloudFront

---

## 🙌 Connect With Me

If you're also learning Cloud/DevOps, let's connect on LinkedIn!

---
