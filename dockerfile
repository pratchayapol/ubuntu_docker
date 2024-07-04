FROM ubuntu:latest

# ติดตั้ง OpenSSH Server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /var/run/sshd

# สร้างโฟลเดอร์สำหรับ SSH keys
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# ตั้งรหัสผ่าน root (เปลี่ยน password เป็นรหัสผ่านที่คุณต้องการ)
RUN echo 'root:151143' | chpasswd

# อนุญาตการเชื่อมต่อ SSH root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# อนุญาตการใช้รหัสผ่านสำหรับ SSH
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# เปิด port 22 สำหรับ SSH
EXPOSE 22

# รัน SSH server
CMD ["/usr/sbin/sshd", "-D"]
