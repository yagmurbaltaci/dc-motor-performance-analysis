V = 24;
R = 2;
Ke =0.1;
Kt = 0.1;

omega0 = V / Ke;
rpm0 =omega0 * 60 / (2*pi);

Istall = V / R;
Tstall = Kt * Istall;

T = linspace(0, Tstall, 100);

omega = (V - R * (T / Kt)) / Ke ;
rpm = omega * 60 / (2*pi);

plot(T, rpm);
title('DC Motor Torque-Speed Characteristic');
xlabel('Torque (N.m)');
ylabel('Motor Speed (RPM)');
grid on;

voltages = [12 18 24];

figure;
hold on;

for i = 1:3
    Vtest = voltages(i);
    Istall_test = Vtest / R;
    Tstall_test = Kt * Istall_test;
    Ttest = linspace(0, Tstall_test, 100);
    omega_test = (Vtest - R * (Ttest / Kt))/ Ke ;
    rpm_test = omega_test * 60 / (2*pi);

    plot(Ttest, rpm_test);
end

title('DC Motor Torque-Speed Comparison');
xlabel('Torque (N.m)');
ylabel('Motor Speed (RPM)');
legend('12V', '18V', '24V');
grid on;
hold off;

% Mechanical Power Analysis
P = T .* omega;

figure(3);
plot(T, P);
title('DC Motor Mechanical Power');
xlabel('Torque (N.m)');
ylabel('Mechanical Power (W)');
grid on;

[Pmax, idx] = max(P);

T_at_Pmax = T(idx);
rpm_at_Pmax = rpm(idx);

figure(3);
hold on;
plot(T_at_Pmax, Pmax, 'ro', 'MarkerSize',8, 'LineWidth',2);
text(T_at_Pmax + 0.05, Pmax, ...
    sprintf('Max Power: %.02f W', Pmax));
hold off;

fprintf(';\ln--- DC MOTOR ANALYSIS RESULTS ---\ln');
fprintf('Supply Voltage: %.0f V\n', V);
fprintf('No-load Speed: %.0f RPM\n', rpm0);
fprintf('Stall Torque: %.2f N.m\n', Tstall);
fprintf('Maximum Mechanical Power: %.2f W\n', Pmax);
fprintf('Torque at Maximum Power: %.2f N.m\n', T_at_Pmax);
fprintf('Speed at Maximum Power: %.0f RPM\n', rpm_at_Pmax);