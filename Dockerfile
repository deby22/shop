# ./Dockerfile
FROM elixir:1.12

# install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# cache and create our app folder with copy our code in it and set it as default
# RUN mkdir /app
WORKDIR /app

COPY mix.exs .
COPY mix.lock .

RUN mix do deps.get, deps.compile
# COPY . /app

RUN echo 'export ERL_AFLAGS="-kernel shell_history enabled"' >> ~/.bashrc

CMD mix do deps.get, compile &&  mix phx.server