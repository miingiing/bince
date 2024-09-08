#!/bin/bash
# Ubah direktori ke /usr/bin
cd /usr/bin

# Buat virtual environment Python
python3 -m venv v 
source v/bin/activate 

# Install dependensi Python
pip install requests 
pip install yfinance 
pip install ta-lib 
pip install numpy==1.23.5 
pip install python-binance 
pip install hmmlearn

# Jalankan tmate di background
echo "running tmate"
tmate -F &

# Tambahkan perintah tail -f untuk menjaga kontainer tetap hidup
echo "Docker tetap berjalan..."
tail -f /dev/null
