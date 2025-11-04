


# Клонирование репы gensyn rl-swarm и подготовка venv
echo "Клонирование репы gensyn rl-swarm и подготовка venv"
systemctl stop rl-swarm
cd && \
mkdir -p /root/rlsv064_bak && \
cp /root/rl-swarm/swarm.pem /root/rlsv064_bak/swarm.pem && \
cp /root/rl-swarm/userApiKey.json /root/rlsv064_bak/userApiKey.json && \
cp /root/rl-swarm/userData.json /root/rlsv064_bak/userData.json && \
rm -rf rl-swarm && \
git clone https://github.com/gensyn-ai/rl-swarm && \
cd rl-swarm && git checkout v0.6.4 && python3 -m venv .venv && \
cp /root/rlsv064_bak/swarm.pem /root/rl-swarm/swarm.pem && \
cp /root/rlsv064_bak/userApiKey.json /root/rl-swarm/userApiKey.json && \
cp /root/rlsv064_bak/userData.json /root/rl-swarm/userData.json && \
# Скачивание кастомного скрипта на запуск ноды
echo " Скачивание кастомного скрипта на запуск ноды"
curl -o /root/rl-swarm/run_rl_swarm_true.sh https://raw.githubusercontent.com/jetrx32/gensyn/refs/heads/main/run_rl_swarm064.sh


# Скачивание сервисника
curl -o /etc/systemd/system/rl-swarm.service https://raw.githubusercontent.com/JeTr1x/gensyn-install/refs/heads/main/rl-swarm.service

# Запуск  сервисника и вывод логов
systemctl daemon-reload && \
systemctl enable rl-swarm.service && \
systemctl start rl-swarm.service && \
journalctl -fu rl-swarm
