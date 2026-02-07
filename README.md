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
