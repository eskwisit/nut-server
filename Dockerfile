FROM python:3.10-slim

LABEL author='eskwisit'
LABEL description='Slim Docker container featuring embedded Nut server from blawar/nut latest release that works for most.'
LABEL repo='eskwisit/nut-server'
LABEL email='mru2683@gmail.com'

# Prepare Nut install
RUN apt-get update && apt-get -y install \
	wget \
	unzip \
	gcc \
	libssl-dev \
	libcurl4-openssl-dev \
	zlib1g-dev \
	libjpeg-dev

# Fetch Nut codebase
RUN wget https://github.com/blawar/nut/archive/refs/tags/v3.3.zip
RUN unzip v3.3.zip -d /root
RUN mv /root/nut-3.3 /root/nut

# Edit config
RUN mv /root/nut/conf/nut.default.conf /root/nut/conf/nut.conf
RUN sed -i '/scan/c "scan": ["\/titles"]' /root/nut/conf/nut.conf

# Remove GUI packages
RUN sed -i '/pyqt5/d' /root/nut/requirements.txt
RUN sed -i '/qt-range-slider/d' /root/nut/requirements.txt

# Add missing requirements
RUN echo markupsafe==2.0.1 >>/root/nut/requirements.txt

# Install project dependencies
RUN pip3 install -U pip
RUN pip3 install -r /root/nut/requirements.txt

VOLUME [ "/titles", "/root/nut/conf", "/root/nut/_NSPOUT" ]

EXPOSE 9000

# clean up
RUN rm v3.3.zip
RUN apt-get autoremove

CMD ["python3", "/root/nut/nut.py", "--server"]
