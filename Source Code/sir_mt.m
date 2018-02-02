figure(99); clf; hold on
for i=1:816
    plot3(X(i), Z(i), Y(i),'color',C(i,:)./255,'marker','.','markersize',10);
end
for i=1:size(PC,1)/4
    figure(99);plot3(PC((i-1)*4+1,1),PC((i-1)*4+2,1),PC((i-1)*4+3,1),'o');
end