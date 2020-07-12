:- include('informada.pl').
:- include('naoinformada.pl').
:- include('dados.pl').
:- include('dados2rev.pl').


% paragem (_,_,_,_,_,_,_,_,_,_,_,_)


%
% Calcular um trajeto entre dois pontos
%
pergunta1(Id1,Id2,Caminho) :-  caminhoInformado(Id1,Id2,Caminho).








%
% Selecionar apenas algumas das operadoras de transporte para um determinado percurso;
%

pergunta2(Id1,Id2,Caminho,Operadoras):-caminhoInformadoOperadoras(Id1,Id2,Caminho,Operadoras).









%
% Excluir um ou mais operadores de transporte para o percurso;
%

pergunta3(Id1,Id2,Caminho,Operadoras):-caminhoInformadoSemOperadoras(Id1,Id2,Caminho,Operadoras).









%
% Identificar quais as paragens com o maior número de carreiras num determinado percurso
%
pergunta4(Id1,Id2,X):- caminhoInformado(Id1,Id2,Caminho), pergunta4aux(Caminho,Y) ,keysort(Y, Z), reverse(Z,X).

pergunta4aux([H],[(N-H)]) :- quantasCarreiras(H,N).
pergunta4aux([H1|T1],[(N-H1)|T2]) :- quantasCarreiras(H1,N), pergunta4aux(T1,T2) .
	
quantasCarreiras(Id,N):- findall(X, paragem(_,X,Id,_,_,_,_,_,_,_,_,_), Y) , length(Y,N).








%
% Escolher o menor percurso (usando critério menor número de paragens);
%

pergunta5(Id1,Id2,X):- caminhoInformado(Id1,Id2,Caminho) , length(Caminho,L), closerMult2(L,2,Len) , Inc is Len/2, caminhoCurto(Id1,Id2,X,Len,Inc).


caminhoCurto(Id1,Id2,X,Len,0.5):-write('Vou tentar '),write(Len),write('\n'),caminhoMax(Id1,Id2,X,Len).

caminhoCurto(Id1,Id2,X,Len,0.5):-write('Vou tentar '),LenMais is Len+1,write(LenMais), caminhoMax(Id1,Id2,X,LenMais).



caminhoCurto(Id1,Id2,X,Len,Inc):-LenMenos is Len - Inc ,LenMais is Len + Inc , MeioInc is Inc/2,
							(

							(write('Vou tentar '),write(Len),write('\n'),existeCaminhoMax(Id1,Id2,Len),caminhoCurto(Id1,Id2,X,LenMenos,MeioInc)       )
							;
							(caminhoCurto(Id1,Id2,X,LenMais,MeioInc))

							) .

%fazer com o naoIinformadoMax





closerMult(Valor,Mult) :- closerMult2(Valor,2,Mult).
closerMult2(Valor,Temp,Mult) :- Valor>Temp, Temp2 is Temp*2,closerMult2(Valor,Temp2,Mult).
closerMult2(_,X,Y):-Y is X/2.
%
% Escolher o percurso mais rápido (usando critério da distância);
%

%TODO





%
% Escolher o percurso que passe apenas por abrigos com publicidade;
%

pergunta7(Id1,Id2,X) :- caminhoInformadoPub( Id1 , Id2 , X).







%
% Escolher o percurso que passe apenas por paragens abrigadas;
%

pergunta8(Id1,Id2,X) :-caminhoInformadoAbrigo( Id1 , Id2 , X).






%
% Escolher um ou mais pontos intermédios por onde o percurso deverá passar
%


pergunta9(Id1,Id2,X,Interm):- montaCaminho(Id1,Id2,Y,Interm) , flatten(Y, X).

montaCaminho(Id1,Id2,[Caminho],[])    :- caminhoInformado(Id1,Id2,Caminho).

montaCaminho(Id1,Id2,[H|T],[Y] )    :-caminhoInformado(Id1,Y,Htemp),deleteLast(Htemp,H), montaCaminho(Y,Id2,T,[]).

montaCaminho(Id1,Id2,[H|T],[H2|T2]) :-  caminhoInformado(Id1,H2,Htemp),deleteLast(Htemp,H), montaCaminho(H2,Id2,T,T2).



deleteLast([_], []).
deleteLast( [H|T],[H|T2] ):- deleteLast(T,T2).














:- set_prolog_flag(toplevel_print_options,[quoted(true), portrayed(true), max_depth(0)]). %para imprimr lista toda
:- set_prolog_flag(answer_write_options,[max_depth(0)]).%para imprimr lista toda
:- use_module(library(lists)). %reverse e reverse?
:- use_module(library(pairs)). %pares para a pergunta4
:- use_module(library(statistics)). %para medir tempo