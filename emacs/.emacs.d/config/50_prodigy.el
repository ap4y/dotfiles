(prodigy-define-service
  :name "MySQL container"
  :command "docker"
  :args '("run" "--rm" "-p" "3306:3306" "-e" "MYSQL_ROOT_PASSWORD=root" "mysql"))

(prodigy-define-service
  :name "Postgres container"
  :command "docker"
  :args '("run" "--rm" "-p" "5432:5432" "postgres"))

(prodigy-define-service
  :name "Redis container"
  :command "docker"
  :args '("run" "--rm" "-p" "6379:6379" "redis"))

(prodigy-define-service
  :name "ETCD container"
  :command "docker"
  :args '("run" "--rm" "-p" "4001:4001" "microbox/etcd" "-name" "localhost"))

(prodigy-define-service
  :name "ES container"
  :command "docker"
  :args '("run" "--rm" "-p" "9200:9200" "elasticsearch:1.6"))

(prodigy-define-service
  :name "Weechat"
  :command "weechat")
