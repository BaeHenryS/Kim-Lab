lognoiseplot_100k = figure;

figure(lognoiseplot_100k)


x = x_100k/1000;

y1 = dacv0_100k_1v_001* 10^9;

y2 = yoko_100k_1v_001* 10^9;

y3 = keithley_100k_1v_001* 10^9;


semilogy(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

semilogy(x, y2, 'b', ...
    'LineWidth',1.5)
semilogy(x, y3, 'r', ...
    'LineWidth',1.5)

title('Log Noise Measurement Plot at 1V Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko', 'Keithley'},'FontSize',16)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off

noiseplot_100k = figure;
figure(noiseplot_100k)

x = x_100k/1000;

y1 = dacv0_100k_1v_001* 10^9;

y2 = yoko_100k_1v_001 * 10^9;

y3 = keithley_100k_1v_001 * 10^9;


plot(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

plot(x, y2, 'b', ...
    'LineWidth',1.5)
plot(x, y3, 'r', ...
    'LineWidth',1.5)

title('Noise Measurement Plot at 1V Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko', 'Keithley'},'FontSize',16)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off


dacyokocompare_100k = figure;
figure(dacyokocompare_100k)

x = x_100k/1000;

y1 = dacv0_100k_1v_001* 10^9;

y2 = yoko_100k_1v_001 * 10^9;



plot(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

plot(x, y2, 'b', ...
    'LineWidth',1.5)


title('Noise Measurement Plot at 1V Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko'},'FontSize',16)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off