#!/bin/bash
cd /usr/bin
python3 -m venv venv \
&& source venv/bin/activate \
&& python3 info.py
