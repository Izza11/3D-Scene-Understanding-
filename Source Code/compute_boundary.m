function [ hullx, hully ] = compute_boundary(x,y)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    % Pete's sample data:
%     x = [ 82 83 84 85 82.1 86.5 81.5 83.4 84.9 85.2 83 82 82.1 86.4 86.5];
%     y = [ 1 2.2 3.3 2 4 5 2 3.2 2.5 2.4 2.1 1.5 2.3 2.1 1.9];
    figure;
    scatter(x,y);
    % Enlarge figure to full screen.
    % set(gcf, 'Position', get(0,'Screensize'));
    % 
    hullIndexes = convhull(x,y)
    hullx = x(hullIndexes);
    hully = y(hullIndexes);
    hold on;
    plot(hullx, hully, 'r-', 'LineWidth', 2);
    hold off;

end

