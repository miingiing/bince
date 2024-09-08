#!/bin/bash
# Ubah direktori ke /home/coder/project
cd /usr/bin
python3 -m venv v 
source v/bin/activate 
pip install requests 
pip install yfinance 
pip install ta-lib 
pip install numpy==1.23.5 
pip install python-binance 
pip install hmmlearn

echo "running tmate"
tmate -F &
sleep 5

# Ubah direktori ke /usr/bin dan jalankan hms

