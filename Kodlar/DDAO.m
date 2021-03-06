
%% Problem Parameters
function [bestSolution,  bestFitness]=DDAO(komsu_sayisi, uzaklik_bagintisi_no,Npop,MaxIt,U_limit,L_limit,VarLength)


%  Nvar = 10;              % Number of Variables
% VarLength = [1 Nvar];   % solution vector size
% L_limit = -10;          % Lower limit of solution vector
% U_limit = 10;           % Upper limit of solution vector
t=1;
%% DDAO Parameters
% MaxIt= 500;     % Maximum Number of Iterations MaxIt 500 MaxSubIt 10000
MaxSubIt=200;    % Maximum Number of Sub-iterations
T0=50;       % Initial Temp.
alpha=0.995;     % Temp. Reduction Rate
% Npop=3;        % Population Size
%% Initialization
empty_template.Phase=[];
empty_template.Cost=[];
pop=repmat(empty_template,Npop,1);
% Initialize Best Solution
BestSol.Cost=inf;
% Initialize Population
for i=1:Npop
    % Initialize Position
    pop(i).Phase= unifrnd(L_limit,U_limit,VarLength);
    % Evaluation
    % pop(i).Cost=CostFunction(pop(i).Phase);
    pop(i).Cost= Sezgisel_k_nn(komsu_sayisi, uzaklik_bagintisi_no,pop(i).Phase);
    % Update Best Solution
    if pop(i).Cost<=BestSol.Cost
        BestSol=pop(i);
    end
end
% Vector to Hold Best Costs
BestCost=zeros(MaxIt,1);
y=BestSol.Cost;

% Intialize Temp.
T = T0;
%% main loop
% for t=1:MaxIt
while(t<MaxIt)
    newpop = repmat(empty_template,MaxSubIt,1);
    
    for subit=1:MaxSubIt
        % Create and Evaluate New Solutions
        newpop(subit).Phase = unifrnd(L_limit,U_limit,VarLength);
        % set the new solution within the search space
        newpop(subit).Phase = max(newpop(subit).Phase, L_limit);
        newpop(subit).Phase = min(newpop(subit).Phase, U_limit);
        % Evaluate new solution
        % newpop(subit).Cost=CostFunction(newpop(subit).Phase);
        newpop(subit).Cost=Sezgisel_k_nn(komsu_sayisi, uzaklik_bagintisi_no,(newpop(subit).Phase)');
        t=t+1;
    end
    % Sort Neighbors
    [~, SortOrder]=sort([newpop.Cost]);
    newpop=newpop(SortOrder);
    bnew = newpop(1);
    kk = randi(Npop);
    bb = randi(Npop);
    % forging parameter
    %
    %         if(rem(t,2)==1)
    %         Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase;
    %         elseif (rem(t,2)==0)
    %              Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase*rand;
    %         end
    
    if(rem(t,2)==1)
        if(rand<0.9)
            Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase;
        else
            Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase;
        end
    elseif (rem(t,2)==0)
        if(rand<0.9)
            Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase*rand;
        else
            Mnew.Phase = (pop(kk).Phase-pop(bb).Phase)+ bnew.Phase*rand;
        end
    end
    % set the new solution within the search space
    Mnew.Phase = max(Mnew.Phase, L_limit);
    Mnew.Phase = min(Mnew.Phase, U_limit);
    % Evaluate new solution
    % Mnew.Cost=CostFunction(Mnew.Phase);
    Mnew.Cost=Sezgisel_k_nn(komsu_sayisi, uzaklik_bagintisi_no,(Mnew.Phase)');
    t=t+1;
    for i=1:Npop
        if Mnew.Cost <= pop(i).Cost
            pop(i)= Mnew;
        else
            DELTA=(Mnew.Cost-pop(i).Cost);
            P=exp(-DELTA/T);
            if rand <= P
                pop(end)= Mnew;
            end
        end
        % Update Best Solution Ever Found
        if pop(i).Cost <= BestSol.Cost
            BestSol=pop(i);
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(t)=BestSol.Cost;
    %     Display Iteration Information
    %     disp(['Iteration = ' num2str(t) ': Best Cost = ' num2str(BestCost(t))]);
    % Update Temp.
    T=alpha*T;
end
bestSolution=BestSol.Phase;
bestFitness=BestSol.Cost;


