(use-package prodigy
  :ensure t
  :commands prodigy
  :config
  (prodigy-define-service
    :name "MySQL container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "docker://mysql" "--environment=MYSQL_ROOT_PASSWORD=root"))

  (prodigy-define-service
    :name "Postgres container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "docker://postgres"))

  (prodigy-define-service
    :name "Redis container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "--interactive" "docker://redis"))

  (prodigy-define-service
    :name "ETCD container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "docker://microbox/etcd" "--" "-name" "localhost"))

  (prodigy-define-service
    :name "ETCD v3 container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "quay.io/coreos/etcd"))

  (prodigy-define-service
    :name "ES container"
    :sudo t
    :command "rkt"
    :args '("--insecure-options=image" "run" "--net=host" "docker://elasticsearch:2.4")))
