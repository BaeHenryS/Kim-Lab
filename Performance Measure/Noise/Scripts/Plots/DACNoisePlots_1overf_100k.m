%Noise Measurement Plot at -10V - 10V Output, 0 - 100kHz, Normal and
%Buffered
% Used Kim-Lab\Performance Measure\Noise\2022_07_25\Noise20220725_1_Workspace.mat

dacv0_100k_vb_001_mod = dacv0_100k_vb_001;


dacv0_100k_vb_001_mod(1:10,:) = [];

x_100k_mod = x_100k;

x_100k_mod(:,1:10) = [];

x_100k_mod = reshape(x_100k_mod, [],1);
DACNoise_ranged_buf_100k = figure;
figure(DACNoise_ranged_buf_100k)

legendcolors = jet(21);

for i = 1:21
   plot(x_100k_mod, dacv0_100k_vb_001_mod(:,i), 'DisplayName',string(i), 'Color',legendcolors(i,:))
   hold on
end

cmap = colormap(jet(21));
cbh = colorbar;
cbh.Ticks = linspace(0,1,11);
cbh.TickLabels = num2cell(linspace(-10,10, 11));
cbh.TickLabelInterpreter = 'latex';
cbh.Label.String = 'Voltage (V)';
cbh.Label.FontSize = 20;
cbh.Label.Interpreter = 'latex';

title('Noise Measurement Plot at -10V - 10V Buffered Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)







dacv0_100k_v_001_mod = dacv0_100k_v_001;


dacv0_100k_v_001_mod(1:10,:) = [];

x_100k_mod = x_100k;

x_100k_mod(:,1:10) = [];

x_100k_mod = reshape(x_100k_mod, [],1);
DACNoise_ranged_norm_100k = figure;
figure(DACNoise_ranged_norm_100k)



legendcolors = jet(21);

for i = 1:21
   plot(x_100k_mod, dacv0_100k_v_001_mod(:,i), 'DisplayName',string(i), 'Color',legendcolors(i,:))
   hold on
end

cmap = colormap(jet(21));
cbh = colorbar;
cbh.Ticks = linspace(0,1,11);
cbh.TickLabels = num2cell(linspace(-10,10, 11));
cbh.TickLabelInterpreter = 'latex';
cbh.Label.String = 'Voltage (V)';
cbh.Label.FontSize = 20;
cbh.Label.Interpreter = 'latex';

title('Noise Measurement Plot at -10V - 10V Output, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)



