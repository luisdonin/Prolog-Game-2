:- dynamic duda_possui/1.
:- dynamic local_duda/1.
:- dynamic banhado/0.
:- dynamic harold_kumar/0.

local_duda(patio).

acessivel(patio, lagoa).
acessivel(patio, casa).
acessivel(patio, floresta).
acessivel(patio, galinheiro).
acessivel(lagoa, patio).
acessivel(casa, patio).
acessivel(floresta, patio).
acessivel(galinheiro, patio).
acessivel(casa, burger_shack).

no_local(bessy, floresta).
no_local(rede, casa).
no_local(burger, casa).
no_local(burger, burger_shack).

iniciar :-
    local_duda(X),
    write('Duda esta em '), write(X), write('.'), nl,
    write('Objetivos:'), nl,
    write('-----------------------Duda & the Chicken-------------------'),nl,
    write('------------------------------------------------------------'),nl,
    write('      *****     '), write('      __ '), nl,
    write('     *     *    '), write('  \\  (o > '), nl,
    write('    *  o o  *   '), write('   \\_//  '), nl,
    write('    *   ^   *   '), write('    //   '), nl,
    write('    *  \\_/  *  '), write('    V_/_  '), nl,
    write('     *     *    '), nl,
    write('      *****     '), nl,
    write('------------------------------------------------------------'),nl,
    write('Para abrir o menu de objetivos digite: "quests"'), nl,
    random(0, 100, R),
    (R < 100 -> asserta(harold_kumar); true),
    rodar.

quests :-
    write('------------------------------------------------------------'),nl,
    write('1. Pegar a rede na casa.'), nl,
    write('2. Comer um burger no burger shack com Harold e Kumar.'), nl,
    write('3. Pegar a galinha na floresta.'), nl,
    write('4. Levar a galinha para o galinheiro.'), nl,
    write('--------------------------Comandos----------------------------------'),nl,
    write('Mover: ir_para(lugar). (patio, casa, lagoa, floresta, burger_shack, galinheiro)'), nl,
    write('Tomar Banho: banhar.'), nl,
    write('Coletar Objetos: pegar(objeto). (bessy, rede)'), nl,
    write('------------------------------------------------------------'),nl.

requisitos(bessy) :-
    duda_possui(rede).

ir_para(burger_shack) :-
    \+ harold_kumar,
    write('Você não pode ir para o burger shack sem encontrar Harold e Kumar na casa.'), nl.
ir_para(casa) :-
    \+ banhado,
    retract(local_duda(_)),
    asserta(local_duda(patio)),
    write('------------------------------------------------------------'),nl,
    write('vc nao pode entrar na casa da dona Lurdes sem tomar banho. Duda voltou para o patio.'), nl,
    write('------------------------------------------------------------'),nl.
ir_para(casa) :-
    harold_kumar,
    local_duda(Y),
    acessivel(Y, casa),
    retract(local_duda(Y)),
    asserta(local_duda(casa)),
    write('     _______  '), nl,
    write('    /       \\ '), nl,
    write('   /         \\ '), nl,
    write('  /  Casa     \\ '), nl,
    write(' /   Da Lurdes \\ '), nl,
    write(' |  _______  | '), nl,
    write(' | |       | | '), nl,
    write(' | |       | | '), nl,
    write(' | |_______| | '), nl,
    write(' |  _______  | '), nl,
    write(' | |    @  | | '), nl,
    write(' | |   /   | | '), nl,
    write(' | |_______| | '), nl,
    write(' |___________| '), nl,
    write('------------------------------------------------------------'),nl,
    write('Duda esta em casa. Harold e Kumar estão aqui também!'), nl.
ir_para(X) :-
    local_duda(Y),
    acessivel(Y, X),
    retract(local_duda(Y)),
    asserta(local_duda(X)),
    write('Duda esta em '), write(X), write('.'), nl.

pegar(bessy) :-
    local_duda(Y),
    no_local(bessy, Y),
    \+ duda_possui(rede),
    write('Você nao tem a rede para pegar a galinha.'), nl.
pegar(X) :-
    local_duda(Y),
    no_local(X, Y),
    (requisitos(X) -> true; true),
    asserta(duda_possui(X)),
    write('Duda pegou '), write(X), write('.'), nl.

comer_burger :-
  duda_possui(burger),
  retract(duda_possui(burger)).
  

finalizado_burger :-
  local_duda(burger_shack),
  \+ duda_possui(burger),
  write('     _______  '), nl,
  write('    /       \\ '), nl,
  write('   /         \\ '), nl,
  write('  /  BURGER  \\ '), nl,
  write(' /   SHACK    \\ '), nl,
  write(' |  _______  | '), nl,
  write(' | |       | | '), nl,
  write(' | |       | | '), nl,
  write(' | |_______| | '), nl,
  write(' |  _______  | '), nl,
  write(' | |       | | '), nl,
  write(' | |       | | '), nl,
  write(' | |_______| | '), nl,
  write(' |___________| '), nl,
  write('------------------------------------------------------------'),nl,
  write('Duda comeu um burger no burger shack com Harold e Kumar!'), nl,
  write('Fim do jogo!'), nl.

finalizado :-
  local_duda(galinheiro),
  duda_possui(bessy),
  write('   O   '), nl,
  write('  /|\\ '), nl,
  write('  / \\ '), nl,
  write('       '), nl,
  write('  _____  '), nl,
  write(' /     \\ '), nl,
  write('/_______\\'), nl,
  write('|  ___  |'), nl,
  write('| /   \\ |'), nl,
  write('| |   | |'), nl,
  write('| |___| |'), nl,
  write('|  ___  |'), nl,
  write('| |   | |'), nl,
  write('| |___| |'), nl,
  write('|_______|'), nl,
  write('|       |'), nl,
  write('|  ^_^  |'), nl,
  write('|_______|'), nl,
  write('------------------------------------------------------------'),nl,
  write('Duda levou a galinha para o galinheiro!'), nl,
  write('Fim do jogo!'), nl.

banhar :-
  local_duda(lagoa),
  asserta(banhado),
  write('    ^  ^  ^  ^    '), nl,
  write('   ^  ^  ^  ^ ^   '), nl,
  write('  ^  ^  ^  ^  ^   '), nl,
  write(' ^  ^  ^  ^  ^ ^  '), nl,
  write('^  ^  ^  ^  ^  ^  '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~O~~~~~~~~ '), nl,
  write(' ~~~~~~~|~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write('------------------------------------------------------------'),nl,
  write('Duda tomou banho na lagoa.'), nl.
banhar :-
  \+ local_duda(lagoa),
  write('    ^  ^  ^  ^    '), nl,
  write('   ^  ^  ^  ^ ^   '), nl,
  write('  ^  ^  ^  ^  ^   '), nl,
  write(' ^  ^  ^  ^  ^ ^  '), nl,
  write('^  ^  ^  ^  ^  ^  '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write(' ~~~~~~~~~~~~~~~~ '), nl,
  write('------------------------------------------------------------'),nl,
  write('Duda não está na lagoa para tomar banho.'), nl.
rodar :-
  \+ finalizado,
  \+ finalizado_burger,
  write('------------------------------------------------------------'),nl,
  write('Digite uma acao: '),nl,
  write('------------------------------------------------------------'),nl,
  read(Acao),
  (call(Acao) -> true; write('Comando inválido.'), nl),
  rodar.