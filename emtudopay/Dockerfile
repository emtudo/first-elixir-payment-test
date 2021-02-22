FROM bitwalker/alpine-elixir:latest

# Set exposed ports
EXPOSE 5000
ENV PORT=5000

ENV MIX_ENV=prod

# COPY yourapp.tar.gz ./
# RUN tar -xzvf yourapp.tar.gz

RUN apk add bash

USER default

CMD ["bash"]

# FROM ciareis/base-elixir:1.11
# 
# WORKDIR /app
# 
# # COPY
# COPY . .
