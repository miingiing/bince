FROM debian
ENV DEBIAN_FRONTEND=noninteractive

# Update sistem dan instal dependensi
RUN apt update && apt upgrade -y && apt install -y \
    ssh git wget nano curl python3 python3-pip tmate

# Download, ekstrak, dan install TA-Lib
RUN wget https://github.com/cihuuy/mybot-binance/raw/main/ta-lib-0.4.0-src.tar.gz \
    && tar --no-same-owner -xvf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib \
    && ./configure --prefix=/usr \
    && make \
    && make install

# Memilih versi Python yang tersedia
RUN PYTHON_VERSIONS=$(ls /usr/bin/python3.9 /usr/bin/python3.11 | grep -Eo 'python3\.[0-9]+') \
    && if echo "$PYTHON_VERSIONS" | grep -q "python3.11"; then \
        PYTHON_VERSION="3.11"; \
    elif echo "$PYTHON_VERSIONS" | grep -q "python3.9"; then \
        PYTHON_VERSION="3.9"; \
    else \
        echo "Versi Python yang diinginkan tidak ditemukan." \
        && exit 1; \
    fi \
    && echo "Menggunakan Python versi $PYTHON_VERSION" \
    && apt install -y python${PYTHON_VERSION}-venv

# Copy file start.sh ke direktori /usr/local/bin
COPY start.sh /usr/local/bin/start.sh

# Berikan izin eksekusi pada start.sh
RUN chmod +x /usr/local/bin/start.sh

# Expose port 8080 (bukan 8090)
EXPOSE 8080

# Jalankan start.sh saat kontainer dimulai
CMD ["/usr/local/bin/start.sh"]
