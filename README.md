# База знаний и онтология по Skyrim

Тематика базы знаний - персонажи, расы, фракции и крики.

## Файлы

| Файл | Что внутри |
|---|---|
| `skyrim.pl` | База знаний на Prolog |
| `examples.txt` | Примеры запросов для Prolog |
| `skyrim.ttl` | Онтология для Protégé |
| `protege_examples.txt` | Примеры запросов для Protégé |

## Prolog

```sh
swipl skyrim.pl
```

## Protégé

Открыть `skyrim.ttl`, включить reasoner (HermiT), выполнять запросы из `protege_examples.txt` во вкладке **DL Query**.
