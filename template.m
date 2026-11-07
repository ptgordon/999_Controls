% <Problem ID>: <one-line description of what this script computes>
%
% Copy into a homework folder as hw_<NN>_<part>.m -- the Makefile runs every
% hw_*.m, captures its console output into output/, and exports a figure PDF
% if the script plots.

% MATLAB ships tf/step/stepinfo in the Control System Toolbox; Octave needs
% the control package loaded explicitly.
if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

% num = [ ];
% den = [ ];
% sys = tf(num, den);

% poles = pole(sys)
% zeros = zero(sys)

% figure;
% step(sys);
