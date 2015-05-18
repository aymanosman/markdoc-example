FROM python:2.7

RUN apt-get update
RUN apt-get install -y rsync nginx
RUN rm /etc/nginx/sites-enabled/default
COPY site.conf /etc/nginx/conf.d/
RUN service nginx start
RUN pip install Markdoc

RUN markdoc init my-wiki --vcs-ignore hg
WORKDIR my-wiki
COPY somefile.md /my-wiki/
RUN markdoc build

EXPOSE 80

CMD ["markdoc", "serve"]
