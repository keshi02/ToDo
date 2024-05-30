From ruby:3.2.2
ARG RUBYGEMS_VERSION=3.3.20

# 作業ディレクトリを指定
RUN mkdir /todo
WORKDIR /todo

# ホストのGemfileをコンテナ内の作業ディレクトリにコピー
COPY Gemfile Gemfile.lock /todo/

# bundle installを実行
RUN bundle install

# アセットプリコンパイル
RUN bundle exec rails assets:precompile

# ホスト(ローカル)のファイルをコンテナ内の作業ディレクトリにコピー
COPY . /todo/

# entrypoint.shをコンテナ内の作業ディレクトリにコピー
COPY entrypoint.sh /usr/bin/

# entrypoint.shの実行権限を付与
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# コンテナ起動時に実行するコマンドを指定
CMD ["rails", "server", "-b", "0.0.0.0"]
