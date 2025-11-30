# Система мониторинга веб-приложения

Автоматизированная система мониторинга и восстановления веб-приложения на Go с использованием systemd и Ansible.

## Файлы проекта

- **web-monitoring.go** - Веб-приложение на Go
- **health-check.sh** - Скрипт проверки здоровья  
- **deploy.yml** - Ansible плейбук для развертывания
- **vars.yml** - Конфигурационные параметры
- **templates/** - шаблоны для создания Systemd-служб приложения
- **templates/web-monitoring.service** - шаблон службы основного приложения
- **templates/health-check.service** - шаблон службы мониторинга приложения
- **templates/health-check.timer** - шаблон службы таймера проверок

## Установка и запуск

### Клонирование репозитория
```bash
git clone https://github.com/Yung-Cristy/yakovlev-test-vk/
cd vk-test
```

### Автоматическое развертывание 
```bash
sudo ansible-playbook deploy.yml
```

### Проверка статуса служб
```bash
sudo systemctl status web-monitoring
sudo systemctl status health-check.timer
```

### Просмотр логов приложения
```bash
sudo journalctl -u web-monitoring -f
```

### Просмотр логов мониторинга
```bash
sudo tail -f /var/log/service-health.log
```

### Тестирование приложения
```bash
curl http://localhost:8080

```

## Ожидаемый ответ: Hello World!

## Конфигурация

Основные настройки в файле `vars.yml`:

| Переменная | Описание |
| :--- | :--- |
| `app_config.name` | Имя systemd службы |
| `app_config.port` | Порт веб-приложения |
| `app_config.host` | Хост для подключения |
| `health_check.interval` | Интервал проверки здоровья |
| `health_check.timeout` | Таймаут HTTP-запроса в секундах |
| `paths.app_dir` | Директория с приложением |
| `paths.log_file` | Файл для логов мониторинга |
| `app_user` | Пользователь для запуска службы |
