
ARG BASE_IMAGE=fedora:latest

# image0
FROM ${BASE_IMAGE}
RUN dnf groupinstall 'Development Tools' -y
RUN dnf install \
    gcc \
    automake \
    autoconf \
    libtool \
    liboath-devel \
    php-devel \
    -y
WORKDIR /build/php-oath
ADD . .
RUN phpize
RUN ./configure CFLAGS="-O3"
RUN make
RUN make install

# image1
FROM ${BASE_IMAGE}
RUN dnf install php-cli liboath -y
# this probably won't work on other arches
COPY --from=0 /usr/lib64/php/modules/oath.so /usr/lib64/php/modules/oath.so
# please forgive me
COPY --from=0 /usr/lib64/php/build/run-tests.php /usr/local/lib/php/build/run-tests.php
RUN echo extension=oath.so | sudo tee /etc/php.d/90-oath.ini
