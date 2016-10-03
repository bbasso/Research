function grid_visualize_policy_and_cost(gridn, pi, c)

figure; hold on; axis([0.5 gridn+.5 0.5 gridn+.5]);

% plot cost
c2d = zeros(gridn,gridn);
for i=1:gridn
	for j=1:gridn
		c2d(i,j) = c(grid_ij2idx(i,j,gridn));
	end
end

imagesc(c2d'); %% transpose b/c x is the first coordinate, y second
colormap(spring)
hold on;
grid on;
for i=1:gridn
	for j=1:gridn
		x1 = i; y1 = j;
		action = pi(grid_ij2idx(i,j,gridn));
		if(action == 2)
			x2 = x1; y2 = y1 + .5;
		elseif(action == 3)
			x2 = x1+.5; y2 = y1;
		elseif(action == 4)
			x2 = x1; y2 = y1 - .5;
		elseif(action == 5)
			x2 = x1-.5; y2 = y1;
		else %% action == 1 -- stay in place
			plot(x1,y1,'.');
			continue;
		end
		plot_arrow(x1,y1,x2,y2);
	end
end
