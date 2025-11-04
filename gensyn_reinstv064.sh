


# Подготовка сервера если до этого gensyn не ставился
if [ ! -f /etc/systemd/system/rl-swarm.service ]; then
  echo "Подготовка сервера"
  bash <(wget -qO- https://raw.githubusercontent.com/JeTr1x/gensyn-install/refs/heads/main/prep.sh)
fi


# Остановка сервиса; удаление файлов
systemctl stop rl-swarm.service && \
rm -rf /root/rl-swarm

# Клонирование репы gensyn rl-swarm и подготовка venv
echo "Клонирование репы gensyn rl-swarm и подготовка venv"
cd && \
git clone https://github.com/gensyn-ai/rl-swarm && \
cd rl-swarm && git checkout v0.6.4 && python3 -m venv .venv && \



# Скачивание кастомного скрипта на запуск ноды
echo " Скачивание кастомного скрипта на запуск ноды"
curl -o /root/rl-swarm/run_rl_swarm_true.sh https://raw.githubusercontent.com/JeTr1x/gensyn-install/refs/heads/main/run_rl_swarm_true.sh


# Скачивание сервисника
curl -o /root/rl-swarm/run_rl_swarm_true.sh https://raw.githubusercontent.com/JeTr1x/aztec_inst/refs/heads/main/run-rlsw-new.sh

# Запуск  сервисника и вывод логов
systemctl daemon-reload && \
systemctl enable rl-swarm.service && \
systemctl start rl-swarm.service && \
journalctl -fu rl-swarm
