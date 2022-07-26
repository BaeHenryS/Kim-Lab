
% 1V Plot at 195Hz Range for DAC, YOKO, Keithley
% Used Kim-Lab\Performance Measure\Noise\2022_07_21\Noise20220721_1_Workspace.mat
% 



lognoiseplot_195 = figure;

figure(lognoiseplot_195)


x = x_195;

y1 = dacv0_195_1v_001 * 10^9;

y2 = yoko_195_1v_001 * 10^9;

y3 = keithley_195_1v_001 * 10^9;


semilogy(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

semilogy(x, y2, 'b', ...
    'LineWidth',1.5)
semilogy(x, y3, 'r', ...
    'LineWidth',1.5)

title('Log Noise Measurement Plot at 1V Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko', 'Keithley'},'FontSize',16)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off

noiseplot_195 = figure;
figure(noiseplot_195)

x = x_195;

y1 = dacv0_195_1v_001* 10^9;

y2 = yoko_195_1v_001 * 10^9;

y3 = keithley_195_1v_001 * 10^9;


plot(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

plot(x, y2, 'b', ...
    'LineWidth',1.5)
plot(x, y3, 'r', ...
    'LineWidth',1.5)

title('Noise Measurement Plot at 1V Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko', 'Keithley'},'FontSize',16)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off


dacyokocompare_195 = figure;
figure(dacyokocompare_195)

x = x_195;

y1 = dacv0_195_1v_001* 10^9;

y2 = yoko_195_1v_001 * 10^9;



plot(x, y1, 'g', ...
    'LineWidth',1.5)

hold on

plot(x, y2, 'b', ...
    'LineWidth',1.5)


title('Noise Measurement Plot at 1V Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
legend({'DAC', 'Yoko'},'FontSize',16)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off