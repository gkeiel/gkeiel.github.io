clc; clear;

f = @(x) x*sin(10*pi*x)+1;      %fun��o objetivo
N=4;                            %n�mero de indiv�duos (solu��es)
L=12;                           %n�mero de itera��es

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Sem codifica��o %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_atual= -1 + (3).*rand(1,N);       %gera um conjunto de solu��es iniciais
x_best= x_atual;
obj_best=zeros(1,N);

fprintf('x=%f ', x_atual); fprintf(' \n\n')

for aux2= 1:N
    obj_at= f(x_atual(aux2)); 
    
    for aux1= 1:L
        x_atual(aux2) = x_atual(aux2) +0.1;           %gera solu��o vizinha       
        
        if (x_atual(aux2) > 2 || x_atual(aux2) < -1)  %restri��o lower and upper bound
            x_atual(aux2)=2;                          %volta para upper bound
        end
        
        obj_new= f(x_atual(aux2));                    %calcula energia do vizinho                  
        
        if (obj_new > obj_at)
            obj_at= obj_new;                          %Seleciona vizinho com maior energia
            x_best(aux2)= x_atual(aux2);              %Salva estado do vizinho com a maior energia 
        else
        end
        fprintf('x=%f ', x_atual(aux2)); fprintf('y=%f \n', obj_at);
    end

    obj_best(aux2)=obj_at;
    fprintf('x_best=%f y=%f \n\n', x_best(aux2), obj_best(aux2));
end

fprintf('x=%f ', x_best); fprintf(' \n')
[obj_neo,i]= max(obj_best);

fprintf('x=%f y=%f \n', x_best(i), obj_neo);