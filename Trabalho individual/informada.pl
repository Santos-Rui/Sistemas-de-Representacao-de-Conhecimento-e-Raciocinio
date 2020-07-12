% CAMINHO INFORMADO CAMINHO INFORMADO CAMINHO INFORMADO CAMINHO INFORMADO CAMINHO INFORMADO 

caminhoInformado( Id1 , Id2 , CaminhoF) :-   caminhoInf( Id1 , Id2 , [Id1] , [Id1] , Caminho  ),   length(Caminho,X) , !, X=\=0 , reverse(Caminho,CaminhoF).

caminhoInf( Id1 , Id2 , Back , _ , [Id2|Back]) :- adj(Id1,Id2).							%cheguei ao destino, caso paragem

caminhoInf( Id1 , Id2 , [H|Back]  , Visitados , Caminho ):- 
			getListaAdj(Id1,Lista),														%lista de nodos			
			escolherAdjacente(Lista , Visitados, Escolhido),							%escolhe 1
		    Escolhido =\= 0 , 															%se for 0 é porque nao ha, vou ter de dar backtrack
		    caminhoInf( Escolhido , Id2 , [Escolhido,H|Back]  , [Escolhido|Visitados] , Caminho ). %ir para o novo nodo


caminhoInf( _ , _ , [_]  , _ , [] ):- write('Nao existe caminho \n ').                  %testei tudo, nao existe, caso paragem de false


caminhoInf( _ , Id2 , [_|Back]  , Visitados , Caminho ):-								%aqui dou backtrack
		primeiro(Back,Primeiro), 
		caminhoInf( Primeiro , Id2 , Back  , Visitados , Caminho ). 



getListaAdj(Id,Lista):-findall(X, adj(Id,X), Lista) .



escolherAdjacente( [] , _ , 0 ) . 
escolherAdjacente([H|_], Visitados , H)       :- not(member(H, Visitados)).
escolherAdjacente([_|T], Visitados, Escolhido):- escolherAdjacente(T, Visitados , Escolhido).



primeiro( [H|_], H ).













%CAMINHO INFORMADO SO PARAGENS COM PUBLICIDIADE



caminhoInformadoPub( Id1 , Id2 , CaminhoF) :-   caminhoInfPub( Id1 , Id2 , [Id1] , [Id1] , Caminho  ),   length(Caminho,X) , !, X=\=0 ,reverse(Caminho,CaminhoF).

caminhoInfPub( Id1 , Id2 , Back , _ , [Id2|Back]) :- adj(Id1,Id2).

caminhoInfPub( Id1 , Id2 , [H|Back]  , Visitados , Caminho ):- 
			getListaAdj(Id1,Lista),
			escolherAdjacentePub(Lista , Visitados, Escolhido),
		    Escolhido =\= 0 , 
		    caminhoInfPub( Escolhido , Id2 , [Escolhido,H|Back]  , [Escolhido|Visitados] , Caminho ).


caminhoInfPub( _ , _ , [_]  , _ , [] ):- write(' Nao existe caminho \n ').


caminhoInfPub( _ , Id2 , [_|Back]  , Visitados , Caminho ):-
		primeiro(Back,Primeiro), 
		Primeiro =\= 0,
		caminhoInfPub( Primeiro , Id2 , Back  , Visitados , Caminho ).





escolherAdjacentePub( [] , _ , 0 ) . 
escolherAdjacentePub([H|_], Visitados , H)       :- not(member(H, Visitados)) , temPub(H).
escolherAdjacentePub([_|T], Visitados, Escolhido):- escolherAdjacentePub(T, Visitados , Escolhido).

temPub(Id):- paragem(_,_,Id,_,_,_,_,'Yes',_,_,_,_) .












%CAMINHO INFORMADO SO PARAGENS COM ABRIGO


caminhoInformadoAbrigo( Id1 , Id2 , CaminhoF) :-   caminhoInfPubAbrigo( Id1 , Id2 , [Id1] , [Id1] , Caminho  ),   length(Caminho,X) , !, X=\=0 , reverse(Caminho,CaminhoF).

caminhoInfPubAbrigo( Id1 , Id2 , Back , _ , [Id2|Back]) :- adj(Id1,Id2).

caminhoInfPubAbrigo( Id1 , Id2 , [H|Back]  , Visitados , Caminho ):- 
			getListaAdj(Id1,Lista),
			escolherAdjacenteAbrigo(Lista , Visitados, Escolhido),
		    Escolhido =\= 0 , 
		    caminhoInfPubAbrigo( Escolhido , Id2 , [Escolhido,H|Back]  , [Escolhido|Visitados] , Caminho ).


caminhoInfPubAbrigo( _ , _ , [_]  , _ , [] ):- write(' Nao existe caminho \n ').


caminhoInfPubAbrigo( _ , Id2 , [_|Back]  , Visitados , Caminho ):-
		primeiro(Back,Primeiro), 
		Primeiro =\= 0,
		caminhoInfPubAbrigo( Primeiro , Id2 , Back  , Visitados , Caminho ).





escolherAdjacenteAbrigo( [] , _ , 0 ) . 
escolherAdjacenteAbrigo([H|_], Visitados , H)       :- not(member(H, Visitados)) , abrigado(H).
escolherAdjacenteAbrigo([_|T], Visitados, Escolhido):- escolherAdjacenteAbrigo(T, Visitados , Escolhido).

abrigado(Id):- paragem(_,_,Id,_,_,_,X,_,_,_,_,_) , X \= 'Sem Abrigo'.





%CAMINHO INFORMADO SO PARAGENS DE CERTAS OPERADORAS


caminhoInformadoOperadoras( Id1 , Id2 , CaminhoF, Operadoras) :-   caminhoInfOperadoras( Id1 , Id2 , [Id1] , [Id1] , Caminho , Operadoras ),   length(Caminho,X) , !, X=\=0 , reverse(Caminho,CaminhoF).

caminhoInfOperadoras( Id1 , Id2 , Back , _ , [Id2|Back] , _ ) :- adj(Id1,Id2).

caminhoInfOperadoras( Id1 , Id2 , [H|Back]  , Visitados , Caminho, Operadoras ):- 
			getListaAdj(Id1,Lista),
			escolherAdjacenteOperadoras(Lista , Visitados, Escolhido , Operadoras),
		    Escolhido =\= 0 , 
		    caminhoInfOperadoras( Escolhido , Id2 , [Escolhido,H|Back]  , [Escolhido|Visitados] , Caminho , Operadoras ).


caminhoInfOperadoras( _ , _ , [_]  , _ , [] , _):- write(' Nao existe caminho \n ').


caminhoInfOperadoras( _ , Id2 , [_|Back]  , Visitados , Caminho , Operadoras ):-
		primeiro(Back,Primeiro), 
		Primeiro =\= 0,
		caminhoInfOperadoras( Primeiro , Id2 , Back  , Visitados , Caminho , Operadoras ).





escolherAdjacenteOperadoras( [] , _ , 0 , _ ) . 
escolherAdjacenteOperadoras([H|_], Visitados , H , Operadoras)       :- not(member(H, Visitados)) , opera(H,Operadoras).
escolherAdjacenteOperadoras([_|T], Visitados, Escolhido , Operadoras):- escolherAdjacenteOperadoras(T, Visitados , Escolhido,Operadoras).

opera(Id,Operadoras):-paragem(_,_,Id,_,_,_,_,_,X,_,_,_), member(X,Operadoras).






%CAMINHO INFORMADO SEM PARAGENS DE CERTAS OPERADORAS


caminhoInformadoSemOperadoras( Id1 , Id2 , CaminhoF, Operadoras) :-   caminhoInfSemOperadoras( Id1 , Id2 , [Id1] , [Id1] , Caminho , Operadoras ),   length(Caminho,X) , !, X=\=0 , reverse(Caminho,CaminhoF).

caminhoInfSemOperadoras( Id1 , Id2 , Back , _ , [Id2|Back] , _ ) :- adj(Id1,Id2).

caminhoInfSemOperadoras( Id1 , Id2 , [H|Back]  , Visitados , Caminho, Operadoras ):- 
			getListaAdj(Id1,Lista),
			escolherAdjacenteSemOperadoras(Lista , Visitados, Escolhido , Operadoras),
		    Escolhido =\= 0 , 
		    caminhoInfSemOperadoras( Escolhido , Id2 , [Escolhido,H|Back]  , [Escolhido|Visitados] , Caminho , Operadoras ).


caminhoInfSemOperadoras( _ , _ , [_]  , _ , [] , _):- write(' Nao existe caminho \n ').


caminhoInfSemOperadoras( _ , Id2 , [_|Back]  , Visitados , Caminho , Operadoras ):-
		primeiro(Back,Primeiro), 
		Primeiro =\= 0,
		caminhoInfSemOperadoras( Primeiro , Id2 , Back  , Visitados , Caminho , Operadoras ).





escolherAdjacenteSemOperadoras( [] , _ , 0 , _ ) . 
escolherAdjacenteSemOperadoras([H|_], Visitados , H , Operadoras)       :- not(member(H, Visitados)) , \+ opera(H,Operadoras).
escolherAdjacenteSemOperadoras([_|T], Visitados, Escolhido , Operadoras):- escolherAdjacenteSemOperadoras(T, Visitados , Escolhido,Operadoras).



