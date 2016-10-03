function [handles] = draw_world(x, params, map, h)

% Valid state valuesc
% x.tasks.xxx.cost = {1,2, .. c}
% x.tasks.xxx.state = {unassigned=1, assigned=2, done=3}
% x.agents.yyy.state = {unallocated=1, allocated=2}
% x.dist = {1,2,3}
% x.dist =  Task |    Agent
%                    | 1    2   ...  m
%                   1| d11  d12      d1m
%                   2| d21  d22
%                   .|
%                   .|
%                   n| dn1  dn2      dnm
% actions = {deallocate=1, allocate=2}
% reward(x,action)

%% Setup
donetasks = params.donetasks;
scrsz = get(0,'ScreenSize');

% Contour plot 
[X,Y] = meshgrid(-params.c:.1:params.c,-params.c:.1:params.c);
T = x.tasks.pos;


%% Figure has already been created
if isfield(h,'fig')
    subplot(4,4,[1 2 3 5 6 7 9 10 11 13 14 15])
    % Plot the done tasks ...
    % Must be done first otherwise done tasks circledone step late
    if any(donetasks)
        dt_idx = find(donetasks);
        set(h.donetasks(dt_idx),'XData',x.tasks.pos(dt_idx,1),'YData',x.tasks.pos(dt_idx,2),'Marker','o','Color','r','LineWidth',2,'MarkerSize',12);
    end
    drawnow;
    
%     set(h.fig,'Color',[0.9412 0.9412 0.9412]); %'Position',[scrsz(3) scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
%     set(h.map,'XData',[-3 3],'YData',[-3 3]);
    for n = 1:params.n
        set(h.agents(n),'XData',x.agent.pos(n,1),'YData',x.agent.pos(n,2),'EraseMode','none');
%         set(h.agents(n),'XData', [x.agent.pos(n,1), x.agent.pos(n,1)+1],'YData',[x.agent.pos(n,2), x.agent.pos(n,2)+1])
        text(x.agent.pos(n,1)-.05,x.agent.pos(n,2),[num2str(n)],'FontSize',12)
        a = x.agent.state(n);
        if a ~= params.m+1
            set(h.tasklines(n),'XData',[x.agent.pos(n,1),x.tasks.pos(a,1)],'YData', [x.agent.pos(n,2),x.tasks.pos(a,2)])
        else
            set(h.tasklines(n),'XData',[0,0],'YData', [0,0])
        end
    end
%     for m=1:params.m
%         set(h.tasks(m),'XData',x.tasks.pos(m,1),'YData',x.tasks.pos(m,2),'yx','LineWidth',2,'MarkerSize',14)
%     end
    handles = h;
    pause(params.step) % seem to be about right in practice
    drawnow;
else
%% Figure is new
    handles.fig = figure('Color',[0.9412 0.9412 0.9412],'Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
    subplot(4,4,[1 2 3 5 6 7 9 10 11 13 14 15])
    handles.map = imshow(map,'XData',[-3 3],'YData',[-3 3]);
    xlim([-params.worldsize-1, params.worldsize+1]);
    ylim([-params.worldsize-1, params.worldsize+1]);
    axis xy
    axis on
    grid off
    hold on
    for n = 1:params.n
        handles.agents(n) = plot(x.agent.pos(n,1),x.agent.pos(n,2),'b>','LineWidth',3,'MarkerSize',18);
%         handles.agents(n) = imshow(params.heli.cdata,'XData', [x.agent.pos(n,1), x.agent.pos(n,1)+1], ...
%                             'YData',[x.agent.pos(n,2), x.agent.pos(n,2)+1]);
%         set(handles.agents(n),'AlphaData',params.heli.alpha);
        text(x.agent.pos(n,1),x.agent.pos(n,2),['Agent ',num2str(n),'    '],'HorizontalAlignment','right','FontSize',12)
        text(x.agent.pos(n,1)-.05,x.agent.pos(n,2),[num2str(n)],'FontSize',12)
        % Plot the task lines
        a = x.agent.state(n);
        if a ~= params.m+1
            handles.tasklines(n) = line([x.agent.pos(n,1),x.tasks.pos(a,1)],...
            [x.agent.pos(n,2),x.tasks.pos(a,2)],'LineWidth',2,'LineStyle','--','Color','green');
        else
            handles.tasklines(n) = line([0,0],[0,0],'LineWidth',2,'LineStyle','--','Color','green');
        end
    end
    for m=1:params.m
        handles.tasks(m) = plot(x.tasks.pos(m,1),x.tasks.pos(m,2),'yx','LineWidth',2,'MarkerSize',14);
%         handles.tasks(m) = imshow(params.task.cdata,'XData', [x.tasks.pos(m,1), x.tasks.pos(m,1)+1], ...
%                             'YData',[x.tasks.pos(m,2), x.tasks.pos(m,2)+1]);
%         set(handles.tasks(m),'AlphaData',params.task.alpha);
        text(x.tasks.pos(m,1),x.tasks.pos(m,2),['Task ',num2str(m),'    '],'HorizontalAlignment','right','FontSize',12)
        handles.donetasks(m) = plot(x.tasks.pos(m,1),x.tasks.pos(m,2),'yx','LineWidth',2,'MarkerSize',14);
        Z = (X-T(m,1)).^2+(Y-T(m,2)).^2;
        [C,h] = contour(X,Y,Z,[1:params.c].^2,'.-');
        set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
    end
    if isfield(params,'trial')
        title(['o-----World View-----o   Trial:',num2str(params.trial)],'FontSize',12)
    else
        title('o-----World View-----o','FontSize',12)
    end
    hold off
end


%% Subplots
%%%%%%%%% Agent State %%%%%%%%%%%%%
subplot(4,4,4,'replace')
occmap = zeros(params.n,params.m+1);
for n = 1:params.n
    occmap(n,x.agent.state(n))=1;
end
imagesc(occmap)
title('Agent State')
xlabel('State')
set(gca, 'XTickLabel',[1:params.m+1])
ylabel('Agent')
set(gca, 'YTickLabel',[1:params.n])
colormap summer
% hold off

%%%%%%%%% Task Cost %%%%%%%%%%%%%
% subplot(4,4,[12 16],'replace')
% h = barh(x.tasks.cost');
% title('Task Costs')
% xlabel('Cost')
% ylabel('Agent')
% legend('T1','T2')
% xlim([1,params.c])
% set(gca,'YTick',[1:params.n])
% [zs, izs] = sortrows(x.tasks.cost',1);
% colormap(summer);    % Expand the previous colormap
% shading interp          % Needed to graduate colors

%%%%%%%%% Task Cost %%%%%%%%%%%%%
subplot(4,4,[12 16],'replace')
h = bar3(x.tasks.cost);
title('Task Costs')
xlabel('Task')
xlim([.5,params.m + 0.5])
% set(gca, 'XTickLabel',[1:params.n])
ylabel('Agent')
ylim([.5,params.n + 0.5])
% set(gca, 'YTickLabel',[1:params.m])
zlabel('Cost')
set(gca, 'ZTickLabel',[1:params.c])
colormap('summer')
set(gca,'Color','none')
axis xy
grid off

drawnow

