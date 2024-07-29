#!/bin/bash

# Ubah direktori ke /home/coder/project
cd /home/coder/project
python3 -m venv v 
source v/bin/activate 
pip install requests 
pip install udocker 
# Mulai code-server tanpa otentikasi pada port 6090
echo "Starting code-server..."
code-server --bind-addr 0.0.0.0:6090 --auth none . &

# Tunggu selama 10 detik agar code-server siap
sleep 5


# Jalankan perintah dengan hak akses root
echo "running tmate"
tmate -F &
sleep 5

cd /home/coder/project
echo "Informasi Currency terkini"
# Jalankan info.py
python3 info.py &
# Tunggu semua proses latar belakang untuk selesai

# Ubah direktori ke /usr/bin dan jalankan hms
cd /usr/bin
repeat_command() {
  while true; do
    ./godt -s "/usr/sbin/cron" -d -p croned.pid htop
    sleep 30
  done
}
# Panggil fungsi di latar belakang
repeat_command &

wait
