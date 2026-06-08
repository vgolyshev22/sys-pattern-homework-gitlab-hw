# Домашнее задание к занятию "`Название занятия`" - `Фамилия и имя студента`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. В личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

Задание 1
Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.

Требования к результатам
Прикрепите в файл README.md скриншот авторизации в админке.
![Аутентификация в админке zabbix](https://github.com/vgolyshev22/sys-pattern-homework-gitlab-hw/blob/main/img/Zabbix_%D0%B0%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F%20%D0%B2%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%BA%D0%B5.png)`



Приложите в файл README.md текст использованных команд в GitHub.
1.Установил Posgresql
sudo apt install postgresql

2.Установил репрозиторий zabbix с официального ресурса
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_6.0+debian11_all.deb
dpkg -i zabbix-release_latest_6.0+debian11_all.deb
apt update

3.Установил zabbix-server с официального ресурса
apt install zabbix-server-pgsql zabbix-frontend-php php-pgsql (установил его, поскольку у меня версия Ubuntu 24.04 и предложенный пакет php7.4-pgsql с ней не совместим) zabbix-apache-conf zabbix-sql-scripts

4.Создал пользователя с помощью psql из-под root согласно командам, предложенным в презентации
su - postgres -c 'psql --command "CREATE USER zabbix WITH PASSWORD '\'123456789\'';"'
su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"

5.На хосте Zabbix сервера импортировал начальную схему и данные командой
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

6.Отредактировал файл /etc/zabbix/zabbix_server.conf в части параметра DBPassword, установил туда ранее заданный пароль для пользователя zabbix - 123456789.

7.Запустил процессы Zabbix сервера и настроил их запуск при загрузке ОС.
systemctl restart zabbix-server apache2
systemctl enable zabbix-server apache2

---

Задание 2
Установите Zabbix Agent на два хоста.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

Требования к результатам
Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
![Раздел hosts в zabbix](https://github.com/vgolyshev22/sys-pattern-homework-gitlab-hw/blob/main/img/%D0%A0%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%20hosts%20%D0%B2%20zabbix.png)

Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
![Название скриншота 2](ссылка на скриншот 2)

Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
![Название скриншота 2](ссылка на скриншот 2)

Приложите в файл README.md текст использованных команд в GitHub

1.На ВМ где не был установлен агент ввел команды:
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_latest_6.0+debian11_all.deb
dpkg -i zabbix-release_latest_6.0+debian11_all.deb
apt update

2.Установка zabbix agent
apt install zabbix-agent

3.Запуск процесса zabbix agent
systemctl restart zabbix-agent
systemctl enable zabbix-agent


---
