% simulate real system for comparison
[y_o,t_o,x_o] = lsim( sysd, [u 0*w], t);

for k = 1:length(sys.A)
    figure(k)
    plot(t,x_o(:,k),'k','linewidth',2); hold on;
    plot(t,x_(:,k),'bo:','linewidth',2); 
    stairs(t,x(:,k),'r','linewidth',1.5);
    xlabel('Time (s)'); ylabel('Amplitude'); title(['State x_' num2str(k) '(kT)']); grid on;
    legend('real','measured','estimated');
end

figure(k+1)
plot(t,y_o,'k','linewidth',2); hold on;
plot(t,z,'bo:','linewidth',2);
stairs(t,y,'r','linewidth',1.5);
xlabel('Time (s)'); ylabel('Amplitude'); title('Output y(kT)'); grid on;
legend('real','measured','estimated');