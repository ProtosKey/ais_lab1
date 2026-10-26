% race(Race) - игровая раса
race(nord).
race(imperial).
race(breton).
race(redguard).
race(altmer).
race(dunmer).
race(bosmer).
race(orsimer).
race(khajiit).
race(argonian).

% creature_type(Type) - тип существа
creature_type(living).
creature_type(dragon).
creature_type(undead).
creature_type(daedra).
creature_type(automaton).

% character(Name) - персонаж игры
character(ulfric).
character(galmar).
character(tullius).
character(rikke).
character(delphine).
character(esbern).
character(arngeir).
character(dragonborn).
character(alduin).
character(paarthurnax).
character(odahviing).
character(azura). % даэдрический принц рассвета и сумерек
character(meridia). % даэдрический принц жизни и света
character(molag_bal). % даэдрический принц господства
character(hermaeus_mora). % даэдрический принц знаний

% faction(Faction) - фракция
faction(stormcloaks). % Братья Бури
faction(imperial_legion). % Имперский легион
faction(blades). % Клинки
faction(greybeards). % Седобородые

% shout(Shout) - крик
shout(unrelenting_force). % Безжалостная сила
shout(fire_breath). % Огненное дыхание
shout(dragonrend). % Драконобой
shout(whirlwind_sprint). % Стремительный рывок

% dovahkiin(Name) - смертный, рождённый с душой дракона
dovahkiin(dragonborn).

% race_group(Race, Group) - human, mer или beast.
race_group(nord, human).
race_group(imperial, human).
race_group(breton, human).
race_group(redguard, human).
race_group(altmer, mer).
race_group(dunmer, mer).
race_group(bosmer, mer).
race_group(orsimer, mer).
race_group(khajiit, beast).
race_group(argonian, beast).

% race_of(Name, Race) - раса персонажа
% Расу Довакина в игре выбирает игрок, по умолчанию норд
race_of(ulfric, nord).
race_of(galmar, nord).
race_of(tullius, imperial).
race_of(rikke, nord).
race_of(delphine, breton).
race_of(esbern, nord).
race_of(arngeir, nord).
race_of(dragonborn, nord).

% creature_of(Name, Type) - тип существа для персонажей без расы
creature_of(alduin, dragon).
creature_of(paarthurnax, dragon).
creature_of(odahviing, dragon).
creature_of(azura, daedra).
creature_of(meridia, daedra).
creature_of(molag_bal, daedra).
creature_of(hermaeus_mora, daedra).

% member_of(Name, Faction) - рядовой член фракции
member_of(galmar, stormcloaks).
member_of(rikke, imperial_legion).
member_of(delphine, blades).
member_of(esbern, blades).
member_of(dragonborn, blades).
member_of(arngeir, greybeards).

% leader_of(Name, Faction) - лидер фракции
leader_of(ulfric, stormcloaks).
leader_of(tullius, imperial_legion).
leader_of(paarthurnax, greybeards).

% at_war(Faction1, Faction2) - фракции воюют
at_war(stormcloaks, imperial_legion).

% knows_shout(Name, Shout) - персонаж владеет криком
knows_shout(ulfric, unrelenting_force).
knows_shout(arngeir, whirlwind_sprint).
knows_shout(paarthurnax, fire_breath).
knows_shout(alduin, fire_breath).
knows_shout(dragonborn, dragonrend).

% taught(Teacher, Student) - учитель учил ученика крику
taught(paarthurnax, arngeir).
taught(arngeir, ulfric).
taught(arngeir, dragonborn).

% creature_kind(Name, Type) - тип существа персонажа
creature_kind(Name, Type) :-
    creature_of(Name, Type) ;
    ( race_of(Name, _), Type = living ).

% in_group(Name, Group) - группа рас персонажа
in_group(Name, Group) :-
    race_of(Name, Race),
    race_group(Race, Group).

% in_faction(Name, Faction) - персонаж относится к фракции
in_faction(Name, Faction) :-
    member_of(Name, Faction) ;
    leader_of(Name, Faction).

% allies(First, Second) - разные персонажи из одной фракции
allies(First, Second) :-
    in_faction(First, Faction),
    in_faction(Second, Faction),
    First \= Second.

% enemies(First, Second) - персонажи, чьи фракции воюют
enemies(First, Second) :-
    in_faction(First, Faction1),
    in_faction(Second, Faction2),
    ( at_war(Faction1, Faction2) ; at_war(Faction2, Faction1) ).

% voice_lineage(Master, Student) - учитель косвенно или напрямую учил ученика крику
voice_lineage(Master, Student) :-
    taught(Master, Student).
voice_lineage(Master, Student) :-
    taught(Master, Middle),
    voice_lineage(Middle, Student).

% can_defeat_dragon(Name, Dragon) - персонаж может одолеть дракона
can_defeat_dragon(Name, Dragon) :-
    knows_shout(Name, dragonrend),
    creature_kind(Dragon, dragon),
    \+ creature_kind(Name, dragon),
    \+ voice_lineage(Dragon, Name).
