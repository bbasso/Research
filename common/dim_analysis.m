function [s] = dim_analysis(c,M,n)

% M = max num tasks
% n = num agents
close all

%joint agent-task space

s=zeros(1,M)

for m = 1:M
    s1(m) = c^(m*n) * (m+1)^n;
    s2(m) = c^(m*n);
    s3(m) = c^(((m+n-1)*(m+n))/2);
    s4(m) = (c-1)^(m*n) + (c-1)^(((m-1)*m)/2);
end
semilogy(1:M,s1,'-o','LineWidth',2)
hold all
semilogy(1:M,s2,'-o','LineWidth',2)
semilogy(1:M,s3,'-o','LineWidth',2)
semilogy(1:M,s4,'-o','LineWidth',2)

plot([1,M],[10^6,10^6],'--r')
hXLabel = xlabel('Number of Tasks');
hYLabel = ylabel('Number of States');
hTitle = title(['Dim analysis for ',num2str(c),' cost levels, 1 to ',num2str(m),' tasks, and ',num2str(n),' agents'])

hLegend = legend('s1','d(T,A)','full joint state','d(T,A) + d(T,T) (approx)' );


set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel], ...
    'FontName'   , 'AvantGarde');
set([hLegend, gca]             , ...
    'FontSize'   , 10           );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          ,...
    'FontWeight' , 'normal'      );
set( hTitle                    , ...
    'FontSize'   , 12          , ...
    'FontWeight' , 'normal'      );


set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XGrid'       , 'off'      ,...
  'XTick'       , [1:M]        ,...
  'LineWidth'   , 1         );
