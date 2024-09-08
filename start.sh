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
pip install matplotlib 
pip install pandas

# Jalankan tmate di background dengan virtual environment
echo "running tmate"
tmate -F &

# Tambahkan perintah tail -f untuk menjaga skrip tetap berjalan
echo "Docker tetap berjalan..."
while true; do sleep 3600; done
