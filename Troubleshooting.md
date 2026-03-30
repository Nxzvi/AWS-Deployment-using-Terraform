## 🚧 Issues Faced & Fixes

### 🔴 1. Terraform Initialization Failed

**Issue:** Error during `terraform init` after adding backend

**Cause:** S3 bucket for backend was not created before initialization

**Fix:**

* Created S3 bucket manually first
* Re-ran:

```bash
terraform init
```

**Learning:** Backend resources must exist before Terraform can use them.

---

### 🔴 2. Terraform Apply Errors 

**Issue:** Errors while running `terraform apply`

**Cause:** Incorrect resource references and dependency order

**Fix:**

* Used proper references (e.g., `aws_vpc.main.id`)
* Ensured correct linking between VPC → Subnet → EC2

**Learning:** Terraform automatically handles dependencies, but correct references are critical.

---

### 🔴 3. Invalid AMI / Region Mismatch

**Issue:** EC2 instance failed to launch

**Cause:** AMI not valid for selected region

**Fix:**

* Used region-specific Ubuntu AMI (`ap-south-1`)

**Learning:** AMIs are region-specific and must be selected carefully.

---

### 🔴 4. No Internet Access in EC2

**Issue:** EC2 instance could not access internet (apt update failed)

**Cause:**

* Internet Gateway not attached OR
* Route table not configured

**Fix:**

* Attached Internet Gateway to VPC
* Added route:

```text
0.0.0.0/0 → Internet Gateway
```

**Learning:** Internet access requires IGW + proper routing.

---

### 🔴 5. Subnet Not Public

**Issue:** EC2 did not receive public IP

**Cause:** Subnet not configured as public

**Fix:**

* Enabled `associate_public_ip_address = true`
* Used public subnet

**Learning:** Public subnet + public IP required for external access.

---

### 🔴 6. Security Group Blocking Access

**Issue:** Application not accessible via browser

**Cause:** Required ports not open

**Fix:**

* Added inbound rules:

```text
Port 80   → HTTP (Nginx)
Port 8000 → Custom App
Source    → 0.0.0.0/0
```

**Learning:** Security Groups control instance-level traffic.

---

### 🔴 7. Network ACL Blocking Traffic

**Issue:** Traffic still blocked even after Security Group update

**Cause:** Network ACL rules restricting inbound/outbound traffic

**Fix:**

* Allowed inbound/outbound rules for required ports (80, 8000)

**Learning:** NACLs act at subnet level and can override access.

---

### 🔴 8. Nginx Not Accessible

**Issue:** Browser showed connection timeout

**Cause:**

* Nginx not installed OR
* Service not running

**Fix:**

```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
```

**Learning:** Service-level issues must be checked inside EC2.

---

### 🔴 9. Custom Web Page Not Displayed

**Issue:** Default Nginx page still showing

**Cause:** Wrong file edited

**Fix:**

```bash
sudo nano /var/www/html/index.html
sudo systemctl restart nginx
```

**Learning:** Understanding server file structure is important.

---

### 🔴 10. S3 Object Not Accessible

**Issue:** Unable to access file via browser

**Cause:**

* Public access blocked
* No proper permissions

**Fix:**

* Disabled block public access
* Uploaded file correctly

**Learning:** S3 requires explicit permissions for public access.

---

### 🔴 11. Terraform State Not Stored Remotely

**Issue:** State file stored locally instead of S3

**Cause:** Backend not configured properly

**Fix:**

* Added backend config
* Re-initialized Terraform

**Learning:** Remote backend improves collaboration and reliability.

---

### 🔴 12. Port Access Issue

**Issue:** Application deployed but not reachable

**Cause:** Port not exposed in Security Group

**Fix:**

* Opened required port in Security Group

**Learning:** Always verify network + firewall + service together.
