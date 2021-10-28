FROM alpine:3.14

ENV LANG=en_US.UTF-8

RUN apk add --no-cache build-base python3 py3-pip python3-dev libffi-dev
RUN pip3 install --no-cache notebook==6.4.5

CMD ["jupyter", "notebook", "--allow-root", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
