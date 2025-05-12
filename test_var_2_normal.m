clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel
pkg load statistics
pkg load signal

addpath("libs");

set(h, "paperunits", "centimeters")
set(h, "papersize", [13.8 4.8])
set(h, "paperposition", [0, 0, [13.8 4.8]])

set(h, "defaultaxesposition", [0.055, 0.075, 0.935, 0.915])
set(h, "defaulttextfontsize", 9)
set(h, "defaultaxesfontsize", 9)
set(h, "defaulttextfontname", "Palatino Linotype")
set(h, "defaultaxesfontname", "Palatino Linotype")
set(h, "defaulttextcolor", "black")

fm_e = @(x) regexprep(x, '[Ee]([+-])0*(\d+)', 'E$1$2');
fm_m = @(x) strrep(x, '-', '−');
fm_f = @(x) fm_m(fm_e(x));

fcolor = "#333333";
ecolor = "#333333";

step = 1024;
nsam = 1e5;

amps =   [ 3   2  1 ];
omegas = [ 13 34 67 ] * 2*pi;
phase = 2*pi*rand(length(amps), nsam);

tdif_std = 7.15e-5;
tdif_mean = 0;

x0 = linspace(0, 2*pi, step);
err = zeros(nsam, length(x0));

f_s = 1 / (x0(2) - x0(1));
v_obl = 0;

for j = 1 : length(amps)
v_obl = v_obl + amps(j)^2 * (1 - exp(-(omegas(j)^2 * tdif_std^2)/2) * cos(omegas(j)*tdif_mean));
end

for i = 1 : nsam

	x1 = x0 + tdif_mean + gen_randn(step, tdif_std, 's');
	y0 = y1 = zeros(1, step);

	for j = 1 : length(amps)

		y0 = y0 + amps(j)*sin(omegas(j)*x0 + phase(j,i));
		y1 = y1 + amps(j)*sin(omegas(j)*x1 + phase(j,i));

	end

	err(i,:) = e = y1 - y0;

end

v_rea = var(err(:));

v_diff = 100 * (v_obl - v_rea) / v_rea

subplot(1, 2, 1)

xt = 4.5*sqrt(v_rea);
hist(err(:), 600, 100, "facecolor", fcolor, "edgecolor", ecolor)
title('\rm{}{\bf{}(a)} Histogram of the error values')
xlim([-xt xt])
xticks([-xt 0 xt]);
xticklabels(arrayfun(@(val) fm_f(sprintf('%0.1e', val)), [-xt 0 xt], 'UniformOutput', false));
ylabel("Occurences, %");
xlabel("Error value, %");
xticklabels(fm_f(xticklabels));
yticklabels(fm_f(yticklabels));
box on

set(gca, 'xgrid', 'on', ...
         'xminorgrid', 'on', ...
         'xminortick', 'on', ...
         'ygrid', 'off', ...
         'yminorgrid', 'off');

subplot(1, 2, 2)

plot(f_s/step * (0:step-1), 2*abs(fft(e))/step)
title('\rm{}{\bf{}(b)} Spectrum of the error signal')
xlim([0 0.5*f_s])
ylabel("Amplitude");
xlabel("Frequency, Hz");
xticklabels(fm_f(xticklabels));
yticklabels(fm_f(yticklabels));
box on

set(gca, 'xgrid', 'on', ...
         'xminorgrid', 'on', ...
         'xminortick', 'on', ...
         'ygrid', 'off', ...
         'yminorgrid', 'off');

printf('\\textbf{Case 2)} $\\Delta t_{i} \\sim N(\\qty{%0.1e}{s}, \\qty{%0.1e}{s^2})$, $\\Delta t_{s} = \\qty{0}{s}$, $\\delta = \\qty{%0.2f}{\\percent}$ \\vskip6pt \\includegraphics{Pictures/hist_2_normal}\n',  tdif_mean, tdif_std^2, v_diff)

print("hist_2_normal.svg");
