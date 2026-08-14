# Для агентов: Memora MCP локально

Инструкция для агентов и IT-настройки редактора (Cursor / WorkAI).  
Участникам курса на занятиях 1–3 это **не** подключаем: MCP остаётся демонстрацией ведущего / домашним усилением.

**Зачем:** persistent memory между сессиями — факты, TODO, issues, digest по теме. Не заменяет файлы организации; дополняет их.

**Пакет:** `memora-mcp` (PyPI). Команда сервера: `memora-server`.  
Репозиторий: https://github.com/agentic-mcp-tools/memora

---

## 1. Требования

- Python 3.10+ и `pip`
- Редактор с MCP (Cursor / совместимый WorkAI)
- Права писать в локальный путь БД (по умолчанию `~/.local/share/memora/`)

Проверка Python:

```bash
python3 --version
pip3 --version
```

---

## 2. Установка пакета

Минимально (облачные эмбеддинги / TF-IDF из коробки):

```bash
pip3 install memora-mcp
```

Опционально — полностью офлайн-эмбеддинги (~2 GB, PyTorch):

```bash
pip3 install "memora-mcp[local]"
```

Актуальная разработка с Git (если нужен bleeding edge):

```bash
pip3 install "git+https://github.com/agentic-mcp-tools/memora.git"
```

Проверка бинарника:

```bash
which memora-server
memora-server --help
```

Если `memora-server` не в PATH — укажите полный путь из `python3 -m pip show -f memora-mcp` (обычно `.../bin/memora-server`).

---

## 3. Подключение в редакторе (stdio, локальная БД)

Рекомендуемый режим для одного компьютера.

**Глобально (все проекты):** `~/.cursor/mcp.json`  
**Только этот репозиторий:** `.cursor/mcp.json` в корне папки организации

```json
{
  "mcpServers": {
    "memora": {
      "command": "memora-server",
      "args": [],
      "env": {
        "MEMORA_DB_PATH": "~/.local/share/memora/severprom.db",
        "MEMORA_ALLOW_ANY_TAG": "1",
        "MEMORA_GRAPH_PORT": "8765"
      }
    }
  }
}
```

Замечания:

- `MEMORA_DB_PATH` — отдельный файл БД под учебную компанию (не смешивать с личными памятями).
- После правки `mcp.json` перезапустите MCP / редактор, дождитесь зелёного статуса сервера.
- Секреты и API-ключи в git **не** коммитить. Облачный D1/S3 — только в локальном `mcp.json` вне репозитория.

---

## 4. Альтернатива: HTTP-транспорт (отдельный процесс)

Если сервер уже крутится в сети (пример домашней/офисной схемы: `http://HOST:PORT/mcp`):

```bash
memora-server --transport streamable-http --host 127.0.0.1 --port 8800
```

В `mcp.json`:

```json
{
  "mcpServers": {
    "memora": {
      "url": "http://127.0.0.1:8800/mcp"
    }
  }
}
```

Для доступа с других машин в LAN используйте IP хоста и убедитесь, что порт не торчит в публичный интернет без защиты.

---

## 5. Проверка, что агент видит Memora

В Agent-режиме попросите:

1. Вызвать `memory_stats` — должна вернуться статистика (даже пустая).
2. Создать тестовую запись: `memory_create` с тегом вроде `severprom/test`.
3. Найти её через `memory_semantic_search` или `memory_digest` по теме теста.
4. Удалить тестовую запись через `memory_delete`, если она не нужна.

Граф (если включён порт): обычно `http://127.0.0.1:8765`.

---

## 6. Как агентам пользоваться памятью в контексте СеверПром

| Инструмент | Когда |
|------------|--------|
| `memory_create` | Устойчивый факт по компании/курсу (не дублировать то, что уже в md-файлах репо) |
| `memory_create_todo` / `memory_create_issue` | Открытые задачи и проблемы сессии |
| `memory_digest(topic=...)` | Сводка по теме перед ответом |
| `memory_semantic_search` / `memory_hybrid_search` | Поиск по прошлым сессиям |
| `memory_absorb` | Внести пачку фактов с дедупом (осторожно; при сомнении `dry_run`) |

Правила:

1. Источник истины по учебным данным — файлы этой папки (`00-…`–`13-…`). Memora — слой сессий и договорённостей.
2. Не складывать пароли, токены, реальные ПДн.
3. Теги держать иерархичными, например: `severprom/продукт`, `severprom/процесс`, `курс/день4`.
4. Перед длинной работой — `memory_digest` по теме; после важного решения — короткая запись в память.

---

## 7. Типичные сбои

| Симптом | Что проверить |
|---------|----------------|
| Сервер красный / не стартует | `which memora-server`, версия Python, права на `MEMORA_DB_PATH` |
| Команда не найдена | Полный путь к `memora-server` в `command` |
| Пустые поиски | Сначала `memory_stats`; для семантики без OpenAI — `memora-mcp[local]` или backend `tfidf` |
| Конфликт портов графа | Сменить `MEMORA_GRAPH_PORT` или `--graph-port` / `--no-graph` |
| HTTP URL не отвечает | Процесс `memora-server` запущен? firewall? правильный `/mcp` path? |

---

## 8. Снятие / чистая переустановка

```bash
pip3 uninstall memora-mcp
# при необходимости удалить БД:
# rm ~/.local/share/memora/severprom.db
```

Убрать блок `"memora"` из `mcp.json` и перезапустить редактор.
