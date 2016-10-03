% Plot for CDC paper
close all

% Plot made for cdc paper
% not sure what R was


q_steps = [5.8065,4.6350,2.9173,1.5120]';
q_smdp_steps = [4.5207,3.5090,2.8620,1.3702]';
greedy_steps = [3.4355,2.0231,1.7920,1.4303]';

agents = [4,3,2,1];

nS = [164025,11664,729,27]';

hold on;

q_learned = plot(agents,q_steps,'k--','LineWidth',2);
qsmdp_learned = plot(agents,q_smdp_steps,'r--','LineWidth',2);
greedy = plot(agents,greedy_steps,'b--','LineWidth',2);
hTitle = title('Two-agent, multiple task simulation');
hXLabel = xlabel('Number of Tasks');
hYLabel = ylabel('Steps to episode completion');
hLegend = legend('Q policy','Q-SMDP policy','Greedy policy','location', 'NorthWest' );
xlim([.5,4.5])
ylim([0,7])

set(q_learned,'Marker','s','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(qsmdp_learned,'Marker','d','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(greedy,'LineStyle','--','LineWidth',2,'Marker','o','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)


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
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'on'      ,...
  'XTick'       ,1:4        ,...
  'LineWidth'   , 1         );