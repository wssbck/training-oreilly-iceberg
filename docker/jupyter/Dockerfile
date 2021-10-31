FROM alpine:3.14

# install required system-level packages
RUN apk add --no-cache \
                openjdk8 \
                build-base \
                cyrus-sasl-dev \
                libffi-dev \
                git \
                python3 \
                python3-dev \
                py3-pip \
                py3-wheel

# install Python libraries
RUN pip3 install --no-cache \
                notebook==6.4.5 \
                spylon-kernel==0.4.1 \
                pyhive[hive]==0.6.4 \
                pyhive[trino]==0.6.4 \
                pyspark==3.2.0

# install Python Iceberg
RUN git clone https://github.com/apache/iceberg.git
RUN pip3 install -e ./iceberg/python
RUN rm -rf /iceberg/

# enable Scala in Jupyter
RUN python3 -m spylon_kernel install

# prepare environment for training
RUN mkdir _oreilly_iceberg

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
