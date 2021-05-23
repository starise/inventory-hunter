FROM python:3.9
RUN apt update
RUN apt upgrade -y
RUN apt install -y chromium chromium-driver locales locales-all xvfb
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
RUN apt install -y nodejs
RUN npm --prefix /src install puppeteer

ENV LC_ALL it_IT.UTF-8
ENV LANG it_IT.UTF-8
ENV LANGUAGE it_IT.UTF-8

WORKDIR /src
ARG requirements=requirements.txt
COPY $requirements requirements.txt
RUN pip install -r requirements.txt --no-cache-dir
COPY VERSION version.txt
COPY pyproject.toml .
COPY src .

ENTRYPOINT ["./init.bash"]
