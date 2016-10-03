% Plot for CDC paper
close all

% Plot made for cdc paper
% not sure what R was


q_steps =    [6.2963      6.0867      5.5897      5.2181      5.0331      ]';
q_rs_steps = [5.9895      5.1827      5.1128      4.7778      4.8571      ]';
q_smdp_steps = [4.8639      4.7333      4.9063      4.3523      4.1256]';

q_dist =    [1.7004      1.6782      1.5372      1.4378      1.4304      ]';
q_rs_dist = [1.72       1.466      1.4891      1.2737      1.2892     ]';
q_smdp_dist = [1.5365      1.3781      1.3931      1.3114      1.2255 ]';



greedy_steps = [3.3118 3.3118 3.3118 3.3118 3.3118]';
greedy_dist = [1.0433 1.0433 1.0433 1.0433 1.0433]';

horizon = [5,10,20,50,100];

%%
figure(1)
hold on;

q_learned = semilogx(horizon,q_steps,'k-','LineWidth',3);
q_rs_learned = semilogx(horizon,q_rs_steps,'r-','LineWidth',3);
q_smdp_learned = semilogx(horizon,q_smdp_steps,'b-','LineWidth',3);
% greedy = semilogx(horizon,greedy_steps,'b--','LineWidth',2);

hTitle = title('Steps to Completion (2A 2T)');
hXLabel = xlabel('Number of Tasks');
hYLabel = ylabel('Steps to episode completion');
hLegend = legend('Q','Q-RS','Q-SMDP','location', 'NorthEast' );
% xlim([0,100])

set(q_learned,'Marker','s','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(q_rs_learned,'Marker','d','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(q_smdp_learned,'Marker','o','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
% set(greedy,'LineStyle','--','LineWidth',2,'Marker','o','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)


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
  'XTick'       , [5 10 20 50 100]        ,...
  'LineWidth'   , 1         );

%%
figure(2)
hold on;

q_dist = semilogx(horizon,q_dist,'k-','LineWidth',3);
q_rs_dist = semilogx(horizon,q_rs_dist,'r-','LineWidth',3);
q_smdp_dist = semilogx(horizon,q_smdp_dist,'b-','LineWidth',3);
% greedy = semilogx(horizon,greedy_dist,'b--','LineWidth',2);
hTitle = title('Cumulative Distance (2A 2T)');
hXLabel = xlabel('Number of Tasks');
hYLabel = ylabel('Cumulative Distance (km)');
hLegend = legend('Q','Q-RS','Q-SMDP','location', 'NorthEast' );
xlim([0,100])
ylim([1.2,1.8])
set(q_dist,'Marker','s','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(q_rs_dist,'Marker','d','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
set(q_smdp_dist,'Marker','o','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)
% set(greedy,'LineStyle','--','LineWidth',2,'Marker','o','MarkerFaceColor',[.75 .75 1],'MarkerSize',10)


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
  'XTick'       , [5 10 20 50 100]        ,...
  'LineWidth'   , 1         );