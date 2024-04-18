FROM postgres:16

ARG oracle_fdw_version=2_4_0
ARG instantclient_version=19_14

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    libaio1 \
    libaio-dev \
    build-essential \
    make \
    unzip \
    postgresql-server-dev-all \
    postgresql-common \
    wget \
    alien

RUN wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/1923000/oracle-instantclient19.23-basic-19.23.0.0.0-1.x86_64.rpm
RUN wget --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/1923000/oracle-instantclient19.23-devel-19.23.0.0.0-1.x86_64.rpm
RUN alien --scripts oracle-instantclient19.23-basic-19.23.0.0.0-1.x86_64.rpm
RUN alien --scripts oracle-instantclient19.23-devel-19.23.0.0.0-1.x86_64.rpm
RUN dpkg -i oracle-instantclient19.23-basic_19.23.0.0.0-2_amd64.deb
RUN dpkg -i oracle-instantclient19.23-devel_19.23.0.0.0-2_amd64.deb 

# USER postgres
# WORKDIR /home/postgres

RUN wget --no-check-certificate https://github.com/laurenz/oracle_fdw/archive/refs/tags/ORACLE_FDW_2_6_0.zip
RUN unzip ORACLE_FDW_2_6_0.zip

RUN cd oracle_fdw-ORACLE_FDW_2_6_0 && make && make install

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
