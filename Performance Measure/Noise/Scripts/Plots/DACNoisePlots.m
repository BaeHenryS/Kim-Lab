% DAC Noise Measurement Plot at 1V Output, 0 - 100kHz, 0-195Hz
% Used Kim-Lab\Performance Measure\Noise\2022_07_21\Noise20220721_1_Workspace.mat
% 



dacnoise_100k = figure;
figure(dacnoise_100k)

x = x_100k/1000;

y1 = dacv0_100k_1v_001* 10^9;




plot(x, y1, 'g', ...
    'LineWidth',1.5)


title('DAC Noise Measurement Plot at 1V Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off



dacnoise_195 = figure;
figure(dacnoise_195)

x = x_195;

y1 = dacv0_195_1v_001* 10^9;




plot(x, y1, 'g', ...
    'LineWidth',1.5)
xlim([0 195])


title('DAC Noise Measurement Plot at 1V Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off


