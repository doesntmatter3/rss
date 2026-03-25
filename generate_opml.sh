#!/bin/bash
set -e

# --- FAST CHANNELS ---
fast_channels=(
  "nplusone|20"
  "dtfbest|20"
  "biggeekru|20"
  "rozetked|20"
  "disgustingmen|20"
  "solek_yt|20"
  "Nothing_Russia|20"
)

echo "Channel,Time" > rss_times.csv
for ch in "${fast_channels[@]}"; do
  IFS="|" read -r name limit <<< "$ch"
  start=$(date +%s.%N)
  curl -s -m $((limit + 10)) "https://rsshub.rssforever.com/telegram/channel/$name?limit=$limit" > /dev/null || echo "${name},TIMEOUT" >> rss_times.csv
  end=$(date +%s.%N)
  elapsed=$(echo "$end - $start" | bc)
  if [[ "$elapsed" != "" && "$elapsed" != "0" ]]; then
    echo "${name},${elapsed}" >> rss_times.csv
  fi
done

# --- HEAVY CHANNELS ---
heavy_channels=(
  "novosti_efir|10"
  "tass_agency|10"
  "ulpressa|15"
  "russicaRU|10"
  "ejdailyru|15"
  "banksta|15"
  "rusbri|15"
  "brieflyru|10"
  "emet73|10"
  "uet73|10"
  "cooleach_timetravel|10"
  "simbul1648|10"
  "zombaktales|10"
  "obschimplanom|10"
  "firmamelodiya|10"
  "bladerunnerblues|10"
  "amoledwatchfaces|10"
  "old_Moscow|10"
  "togdazine|10"
  "oldkazan|10"
  "eydetat|10"
  "artgallery|10"
  "nazad90|10"
  "luchofficial|10"
)

echo "Channel,Time" > rss_times_heavy.csv
for ch in "${heavy_channels[@]}"; do
  IFS="|" read -r name limit <<< "$ch"
  start=$(date +%s.%N)
  curl -s -m $((limit + 10)) "https://rsshub.rssforever.com/telegram/channel/$name?limit=$limit" > /dev/null || echo "${name},TIMEOUT" >> rss_times_heavy.csv
  end=$(date +%s.%N)
  elapsed=$(echo "$end - $start" | bc)
  if [[ "$elapsed" != "" && "$elapsed" != "0" ]]; then
    echo "${name},${elapsed}" >> rss_times_heavy.csv
  fi
done

# --- GENERATE OPML ---
cat > rss.opml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0">
  <head>
    <title>Telegram RSS - Auto Generated</title>
  </head>
  <body>
    <outline text="Новости" title="Новости">
      <outline text="Прямой Эфир" xmlUrl="https://rsshub.rssforever.com/telegram/channel/novosti_efir?limit=10"/>
      <outline text="ТАСС" xmlUrl="https://rsshub.rssforever.com/telegram/channel/tass_agency?limit=10"/>
      <outline text="УЛПРЕССА" xmlUrl="https://rsshub.rssforever.com/telegram/channel/ulpressa?limit=15"/>
      <outline text="НЕЗЫГАРЬ" xmlUrl="https://rsshub.rssforever.com/telegram/channel/russicaRU?limit=10"/>
      <outline text="ЕЖ" xmlUrl="https://rsshub.rssforever.com/telegram/channel/ejdailyru?limit=15"/>
      <outline text="Банкста" xmlUrl="https://rsshub.rssforever.com/telegram/channel/banksta?limit=15"/>
      <outline text="BRIEF МИР" xmlUrl="https://rsshub.rssforever.com/telegram/channel/rusbri?limit=15"/>
      <outline text="BRIEFLY RU" xmlUrl="https://rsshub.rssforever.com/telegram/channel/brieflyru?limit=10"/>
      <outline text="Өмет" xmlUrl="https://rsshub.rssforever.com/telegram/channel/emet73?limit=10"/>
      <outline text="Трамвай Ульяновск" xmlUrl="https://rsshub.rssforever.com/telegram/channel/uet73?limit=10"/>
    </outline>
    <outline text="Тех и медиа" title="Тех и медиа">
      <outline text="N + 1" xmlUrl="https://rsshub.rssforever.com/telegram/channel/nplusone?limit=20"/>
      <outline text="DTF" xmlUrl="https://rsshub.rssforever.com/telegram/channel/dtfbest?limit=20"/>
      <outline text="Big Geek" xmlUrl="https://rsshub.rssforever.com/telegram/channel/biggeekru?limit=20"/>
      <outline text="Rozetked" xmlUrl="https://rsshub.rssforever.com/telegram/channel/rozetked?limit=20"/>
      <outline text="Disgusting Men" xmlUrl="https://rsshub.rssforever.com/telegram/channel/disgustingmen?limit=20"/>
      <outline text="Solek.exe" xmlUrl="https://rsshub.rssforever.com/telegram/channel/solek_yt?limit=20"/>
      <outline text="Nothing (R)ussia" xmlUrl="https://rsshub.rssforever.com/telegram/channel/Nothing_Russia?limit=20"/>
    </outline>
    <outline text="Остальное" title="Остальное">
      <outline text="Канал Кулича" xmlUrl="https://rsshub.rssforever.com/telegram/channel/cooleach_timetravel?limit=10"/>
      <outline text="48 Колебяток" xmlUrl="https://rsshub.rssforever.com/telegram/channel/simbul1648?limit=10"/>
      <outline text="Сказки Дядюшки Зомбака" xmlUrl="https://rsshub.rssforever.com/telegram/channel/zombaktales?limit=10"/>
      <outline text="Общим планом" xmlUrl="https://rsshub.rssforever.com/telegram/channel/obschimplanom?limit=10"/>
      <outline text="МЕЛОДИЯ" xmlUrl="https://rsshub.rssforever.com/telegram/channel/firmamelodiya?limit=10"/>
      <outline text="Bladerunner Blues" xmlUrl="https://rsshub.rssforever.com/telegram/channel/bladerunnerblues?limit=10"/>
      <outline text="amoledwatchfaces" xmlUrl="https://rsshub.rssforever.com/telegram/channel/amoledwatchfaces?limit=10"/>
      <outline text="Старая Москва" xmlUrl="https://rsshub.rssforever.com/telegram/channel/old_Moscow?limit=10"/>
      <outline text="Тогда" xmlUrl="https://rsshub.rssforever.com/telegram/channel/togdazine?limit=10"/>
      <outline text="Старая Казань" xmlUrl="https://rsshub.rssforever.com/telegram/channel/oldkazan?limit=10"/>
      <outline text="Әйдә! Online" xmlUrl="https://rsshub.rssforever.com/telegram/channel/eydetat?limit=10"/>
      <outline text="Тут картины показываем" xmlUrl="https://rsshub.rssforever.com/telegram/channel/artgallery?limit=10"/>
      <outline text="20 лет назад" xmlUrl="https://rsshub.rssforever.com/telegram/channel/nazad90?limit=10"/>
      <outline text="Луч" xmlUrl="https://rsshub.rssforever.com/telegram/channel/luchofficial?limit=10"/>
    </outline>
  </body>
</opml>
EOF

echo "CSV and OPML generated successfully"
