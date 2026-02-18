# ⚠️ Disclaimer

This script is intended for fresh installations only.  
It will **REMOVE** existing website files and databases on the system.  
DO NOT run this script unless you fully understand what it does.

Before executing, make sure you have a complete backup of your website data.  
Running this script on a production or existing server may result in permanent data loss.

Run the code below to install automatically.
```bash
bash <(wget -qO- https://raw.githubusercontent.com/driverdrift/website-deploy/main/install.sh) y
```
Or run the code below to install manually.
```bash
bash <(wget -qO- https://raw.githubusercontent.com/driverdrift/website-deploy/main/install.sh)
```

# Note:
When using a self-signed certificate, this video file can be downloaded only if the page embedding it has already been opened in the browser.  
Directly downloading the video URL without first loading the webpage may result in a "Network Error" due to TLS trust and browser security checks.  
This is expected behavior with self-signed certificates and not a server-side issue.  
**For production environments, it is strongly recommended to replace this with a certificate issued by a trusted CA (e.g., Let's Encrypt).**

# Import a Self-Signed Certificate When Download Fails
1. Download certificate.
   1. Use sftp to download `/etc/ssl/certs/your_custom_domain.crt` file directly from the server.
   1. Or export it from the browser: Open the website in your browser. Click the padlock icon in the address bar.  
   Go to Certificate → Details → Export. Choose Single Certificate and save it, manually adding the .crt file extension.
1. Double-click the .crt file and choose to open it with `Crypto Shell Extensions` app.
1. Select the `Install Certificate…` option.
1. For Store Location, choose `Local Machine`.
1. Select `Place all certificates in the following store` and click `Browse…`.
1. Choose `Trusted Root Certification Authorities`.
1. Click `Finish` to complete the certificate import.
> Note: You need to **restart your browser** for the certificate to take effect.

# Apply public certificate
1. visit https://dash.cloudflare.com to apply for origin certificate.
2. use Let's Encrypt for free TLS certificates.
