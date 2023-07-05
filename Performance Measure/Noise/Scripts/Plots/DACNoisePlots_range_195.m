%Noise Measurement Plot at -10V - 10V Output, 0 - 195Hz, Normal and
%Buffered
% Used Kim-Lab\Performance Measure\Noise\2022_07_25\Noise20220725_1_Workspace.mat

dacv0_195_vb_001_mod = dacv0_195_vb_001;


dacv0_195_vb_001_mod(1:10,:) = [];

x_195_mod = x_195;

x_195_mod(:,1:10) = [];

x_195_mod = reshape(x_195_mod, [],1);
DACNoise_ranged_buf_195 = figure;
figure(DACNoise_ranged_buf_195)

legendcolors = jet(21);

for i = 1:21
   plot(x_195_mod, dacv0_195_vb_001_mod(:,i)*10^9, 'DisplayName',string(i), 'Color',legendcolors(i,:))
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

title('Noise Measurement Plot at -10V - 10V Buffered Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)







dacv0_195_v_001_mod = dacv0_195_v_001;


dacv0_195_v_001_mod(1:10,:) = [];

x_195_mod = x_195;

x_195_mod(:,1:10) = [];

x_195_mod = reshape(x_195_mod, [],1);
DACNoise_ranged_norm_195 = figure;
figure(DACNoise_ranged_norm_195)



legendcolors = jet(21);

for i = 1:21
   plot(x_195_mod, dacv0_195_v_001_mod(:,i)*10^9, 'DisplayName',string(i), 'Color',legendcolors(i,:))
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

title('Noise Measurement Plot at -10V - 10V Output, 0 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)



