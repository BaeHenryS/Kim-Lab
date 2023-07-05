
dac_LTC6655_100k_v_001_mod = dac_LTC6655_100k_v_001;


%dac_LTC6655_100k_v_001_mod(1:10,:) = [];

x_100k_mod = x_100k;

%x_100k_mod(:,1:10) = [];

x_100k_mod = reshape(x_100k_mod, [],1);
DACNoise_ranged_norm_100k = figure;
figure(DACNoise_ranged_norm_100k)



legendcolors = jet(21);

for i = 1:21
   semilogy(x_100k_mod, dac_LTC6655_100k_v_001_mod(:,i)*10^9, 'DisplayName',string(i), 'Color',legendcolors(i,:))
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

title('DAC Noise Measurement Plot at -10V - 10V Output, 0 - 100kHz with LTC6655','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(kHz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)



