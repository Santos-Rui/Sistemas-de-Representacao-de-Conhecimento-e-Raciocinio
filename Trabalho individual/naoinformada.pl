

%%                                           DETERMINAR SE EXISTE CAMINHO 



% algoritmo mais basico de todos so para ver se chega lá
% testes
% 183 -> 499 (curto)                        = true                                                    
% 183 -> 79  (longo)                        = true 													  
% 349 -> 359 (impossivel, mas "conectado")  = false 											 				
% 349 -> 666 (impossivel e isolado)         = sem resposta											 WRONG-WRONG-WRONG-WRONG
% 556 -> 933 (loop)                         = ciclo infinito  ERROR: Stack limit (1.0Gb) exceeded    WRONG-WRONG-WRONG-WRONG
existeCaminhoBasico(Id1,Id2) :- adj(Id1,Id2).  
existeCaminhoBasico(Id1,Id2) :- adj(Id1,Idm), existeCaminhoBasico(Idm,Id2).




%Isto com , com max de 100 acho que nunca encrava ou da resultado errado. Pode ser usado para determinar o amis curto
%mesmo que o de cima, mas limitamos as iteraçoes 
% testes
% 183 -> 499 (Max=100)(curto)               = true
% 183 -> 79  (Max=100)(longo)               = true
% 183 -> 79  (Max=33)(o mais curto)         = true,  aprox 2 secs
% 183 -> 79  (Max=32)(impossivel)           = false, aprox 2 secs
% 349 -> 359 (impossivel, mas "conectado")  = false, aprox 0.5 secs
% 349 -> 666 (impossivel e isolado)         = false
% 556 -> 933 (loop)                         = false, com 200 encrava
existeCaminhoMax( _ , _ , 1 ) :- ! , fail. 
existeCaminhoMax(Id1,Id2, _ ) :- adj(Id1,Id2).  
existeCaminhoMax(Id1,Id2,Max) :- adj(Id1,Idm), Maxx is Max - 1, existeCaminhoMax(Idm,Id2,Maxx).




%mesmo que o de basico, mas vemos os repetidos
% testes
% 183 -> 499 (Max=100)(curto)               = true
% 183 -> 79  (Max=100)(longo)               = true
% 349 -> 359 (impossivel, mas "conectado")  = false
% 349 -> 666 (impossivel e isolado)         = false
% 556 -> 933 (loop)                         = false
existeCaminhoRep(Id1,Id2)        :- existeCaminhoRepAux(Id1,Id2,[Id1]). % inciializar a lista de visitado

existeCaminhoRepAux(Id1,Id2, _ ) :- adj(Id1,Id2).  
existeCaminhoRepAux(Id1,Id2,Rep) :- adj(Id1,Idm), not(member(Idm,Rep)), existeCaminhoRepAux(Idm,Id2,[Idm|Rep]).





% Para camiunho mais curto é má, mas para ver se existe caminho no geral é capaz de ser melhor

%Os 2 combinados, repetidos e Max de iteraçoes. Fica MUITO mais lento a não ser na dos loops.
% testes
% 183 -> 499 (Max=100)(curto)               = true
% 183 -> 79  (Max=100)(longo)               = true
% 183 -> 79  (Max=33)(o mais curto)         = true , LENTO
% 183 -> 79  (Max=32)(impossivel)           = false, LENTO
% 349 -> 359 (impossivel, mas "conectado")  = false
% 349 -> 666 (impossivel e isolado)         = false
% 556 -> 933 (loop)                         = false
existeCaminhoMaxRep(Id1,Id2,Max)        :- existeCaminhoMaxRepAux(Id1,Id2,[Id1],Max). %inciializar a lista de visitado

existeCaminhoMaxRepAux( _ , _ , _ , 1 ) :- ! , fail.
existeCaminhoMaxRepAux(Id1,Id2, _ , _ ) :- adj(Id1,Id2).  
existeCaminhoMaxRepAux(Id1,Id2,Rep,Max) :- adj(Id1,Idm), Maxx is Max - 1 , not(member(Idm,Rep)), existeCaminhoMaxRepAux(Idm,Id2,[Idm|Rep],Maxx).














%%                                            CALCULAR CAMINHO 



% Algoritmo mais basico de todos para calcular o caminho
%
% testes
% 183 -> 499 (curto)                                          = Calcula o caminho
% 183 -> 79  (longo)                                          = Calcula o caminho
% 349 -> 359 (impossivel, mas "conectado")                    = false
% 349 -> 666 (impossivel e isolado)                           = false
% 556 -> 933 (loop)                                           = ciclo infinito  ERROR: Stack limit (1.0Gb) exceeded
caminhoBasico(Id1,Id2,[Id1,Id2])  :-  adj(Id1,Id2) .
caminhoBasico(Id1,Id2,[Id1| T ])  :-  adj(Id1,Idm), caminhoBasico(Idm,Id2,T) .





% Caminho com max de iteraçoes
%
% testes
% 183 -> 499 (Max=100)(curto)               =  Calcula o caminho
% 183 -> 79  (Max=100)(longo)               =  Calcula o caminho
% 183 -> 79  (Max=33)(o mais curto)         =  Calcula o caminho
% 183 -> 79  (Max=32)(impossivel)           =  false
% 349 -> 359 (impossivel, mas "conectado")  =  false
% 349 -> 666 (impossivel e isolado)         =  false
% 556 -> 933 (Max=100)(loop)                =  false , com 200 encrava
caminhoMax( _ , _ , _ , 1 )      :-  ! , fail.  
caminhoMax(Id1,Id2,[Id1,Id2],_)  :-  adj(Id1,Id2) .
caminhoMax(Id1,Id2,[Id1|T],Max)  :-  adj(Id1,Idm), Maxx is Max - 1 , caminhoMax(Idm,Id2,T,Maxx) .




%Caminho mas com control de repetidos
% 183 -> 499 (Max=100)(curto)               =  Calcula o caminho
% 183 -> 79  (Max=100)(longo)               =  Calcula o caminho
% 349 -> 359 (impossivel, mas "conectado")  =  false
% 349 -> 666 (impossivel e isolado)         =  false
% 556 -> 933 (loop)                         =  false
caminhoRep(Id1,Id2,Caminho)  :- caminhoRepAux(Id1,Id2,Caminho,[Id1]) .

caminhoRepAux(Id1,Id2,[Id1,Id2], _ )   :-  adj(Id1,Id2) .
caminhoRepAux(Id1,Id2,[Id1| T ],Rep)   :-  adj(Id1,Idm) , not(member(Idm,Rep)) , caminhoRepAux(Idm,Id2,T,[Idm|Rep]) .






%Caminho  com control de repetidos e Max
% 183 -> 499 (Max=100)(curto)               =  Calcula o caminho
% 183 -> 79  (Max=100)(longo)               =  Calcula o caminho
% 183 -> 79  (Max=33)(o mais curto)         =  Calcula o caminho MUITO LENTO
% 183 -> 79  (Max=32)(impossivel)           =  false MUITO LENTO
% 349 -> 359 (impossivel, mas "conectado")  =  false algo lento
% 349 -> 666 (impossivel e isolado)         =  false
% 556 -> 933 (Max=100)(loop)                =  false
caminhoMaxRep(Id1,Id2,Caminho,Max)  :- caminhoMaxRepAux(Id1,Id2,Caminho,[Id1],Max) .

caminhoMaxRepAux( _ , _ ,    _    , _ , 1 )        :-  ! , fail.  
caminhoMaxRepAux(Id1,Id2,[Id1,Id2], _ , _ )  :-  adj(Id1,Id2) .
caminhoMaxRepAux(Id1,Id2,[Id1| T ],Rep,Max)  :-  adj(Id1,Idm) , Maxx is Max - 1 , not(member(Idm,Rep)) , caminhoMaxRepAux(Idm,Id2,T,[Idm|Rep],Maxx) .






%AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES AUXILIARES 

