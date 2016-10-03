% Main approximator test thread
clear all

% Init
nS = 4;
nA = 2;
r = [0,0,0,1]';
Q = zeros(nS,nA);
policy = ones(nS,1);
goalstate = 4;

% Function Approximation initialization
order = 2;
params = zeros(1,order)

% Learning initialization
episodes = 100;
gamma = 1;
alpah = .9;
lambda = .5;
epislon = .9;

for ep = 1:episodes
    clear s t act V policy delta e
    t=1; 
    s(1) = 1;
    act(1) = 2;
    e = zeros(nS,nA);
    while s~=goalstate
        %selectaction
        [V act] = max(Q(s,:));
        %take action
        if (act(t)==1) && (s(t)~=1)
            s(t+1) = s(t)-1;
        elseif (act(t)==1) && (s(t)==1)
            s(t+1) = s(t);
        elseif (act(t)== 2)
            s(t+1) = s(t)+1;
        end
        if epislon > rand
            act(t+1) = policy(s(t+1));
        else
            act(t+1) = randint(1,1,[1 nA]);
        end
        % Value fn update
        delta(t) = r(s(t+1)) + gamma*Q(s(t+1),act(t+1)) - Q(s(t),act(t));
        e(s(t),act(t)) = e(s(t),act(t)) + 1;
        for i = 1:nS
            for j = 1:nA
                Q(i,j) = Q(i,j) + alpah*delta(t)*e(i,j);
                e(i,j) = gamma*lambda*e(i,j);
            end
        end
        % Parameter update
        
        if s(t+1)==goalstate
            disp('Episode over, thank you for playing')
        end
        t = t+1;
    end
    ep
    Q
end
            
            