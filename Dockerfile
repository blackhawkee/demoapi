FROM docker-registry-default.9.204.169.137.nip.io/ace/ibm-ace-server-prod:11.0.0.5.1-amd64
ADD *.bar /home/aceuser/initial-config/bars/
EXPOSE 7600 7800 7843 9483
ENV LICENSE accept