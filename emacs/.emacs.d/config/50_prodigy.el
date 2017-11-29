(use-package prodigy
  :ensure t
  :commands prodigy
  :config
  (prodigy-define-service
    :name "MySQL container"
    :command "docker"
    :args '("run" "--rm" "--net" "host" "-e" "MYSQL_ROOT_PASSWORD=root" "mysql"))

  (prodigy-define-service
    :name "Postgres container"
    :command "docker"
    :args '("run" "--rm" "--net" "host" "postgres"))

  (prodigy-define-service
    :name "Redis container"
    :command "docker"
    :args '("run" "--rm" "--net" "host" "redis"))

  (prodigy-define-service
    :name "ETCD container"
    :command "docker"
    :args '("run" "--rm" "--net" "host" "microbox/etcd" "-name" "localhost"))

  (prodigy-define-service
    :name "ES container"
    :command "docker"
    :args '("run" "--rm" "--net" "host" "elasticsearch:1.6")))
