%%  Example Using Matlab invfreqs() command 
%%
%%   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Setup the raw data.  This is simulated experimental data. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Periods = [
4
2
1
0.5
0.2
0.1 ];

Ws = (2*pi) ./ Periods;

Gains = [
   0.831639474259661
   0.561435832548028
   0.261189817880566
   0.101983185877470
   0.033648116659521
   0.016152022818775]

Phases = [
  -41.6187915810549
  -69.7959867048385
  -94.3590297220614
  -102.5954673199546
  -98.1945637194365
  -94.4362358923972]; 

%% Compute the complex gain based on the data 
Hs = Gains .* exp(j * Phases * (pi/180));

%% Here, the weights are set up simply to be 1.0 
Weights = ones(size(Ws));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Do fit to two poles and one zero, measure the residual errors. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% These lines do the fit. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Set up for two poles and one zero 
na = 2; 
nb = 0;        

%% Do the fit, B20 and A20 are the numerator and denominator polynomials of the best fit
%% with two poles and one zero. 
[B20, A20] = invfreqs(Hs, Ws, nb, na, Weights)

%% The freqs command takes pole and zero polynomials, and returns the complex gain based on the transfer function. 
%% These lines of code compute the complex gain (HHat), and corresponding PhaseAngles
HHat20     = freqs(B20, A20, Ws);
PhaseHat20 = atan2(imag(HHat20), real(HHat20)) * (180/pi); 

%% The residual error is measured as the norm of the differences in the complex gains. 
Residuals(na, nb+1) = norm( Hs - HHat20 );

%% Plot the bode plot, of the experimental data, and fit model 
figure(1), clf
  subplot(2,1,1)
    semilogx(Ws, 20*log10(Gains), 'b+', Ws, 20*log10(abs(HHat20)), 'ro', 'markersize', 10)
    ylabel('Magnitude dB'); grid on 
    title(sprintf('Invfreqs fit, na = %d, nb = %d, residual = %8.4f', na, nb, Residuals(na, nb+1)));

  subplot(2,1,2)
    semilogx(Ws, Phases, 'b+', Ws, PhaseHat20, 'ro', 'markersize', 10)
    ylim([-360 0])
    ylabel('Phase [degrees]'); grid on 
    xlabel('Frequency [radians/second]')

%% Plot the pole-zero map 
figure(2), clf 
  pzmap(B20, A20)
  axis equal  %% This line sets the horizontal-vertical scale to be 1:1 
  axis([-40 10 -20 20])
  title('Pole-zero Map.  Best Fit.  Two Poles, No Zero') 
  
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% No Do the fit with 3 poles and 1 zero 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These lines do the fit. 
na = 3; 
nb = 1;       
%% Determine the numerator and denominator polynomials 
[B31, A31] = invfreqs(Hs, Ws, nb, na, Weights)

%% The freqs command takes pole and zero polynomials, and returns the complex gain based on the transfer function.  
HHat31    = freqs(B31, A31, Ws);
PhaseHat31 = atan2(imag(HHat31), real(HHat31)) * (180/pi); 
Residuals(na, nb+1) = norm( Hs - HHat31 );


%% Plot the bode plot, of the experimental data, and fit model 
figure(3), clf
  subplot(2,1,1)
    semilogx(Ws, 20*log10(Gains), 'b+', Ws, 20*log10(abs(HHat31)), 'ro', 'markersize', 10)
    ylabel('Magnitude dB'); grid on 
    title(sprintf('Invfreqs fit, na = %d, nb = %d, residual = %8.4f', na, nb, Residuals(na, nb+1)));

  subplot(2,1,2)
    semilogx(Ws, Phases, 'b+', Ws, PhaseHat31, 'ro', 'markersize', 10)
    ylim([-360 0])
    ylabel('Phase [degrees]'); grid on 
    xlabel('Frequency [radians/second]')


%% Plot the pole-zero map 
figure(4), clf 
  pzmap(B31, A31)
  axis equal
  axis([-80 100 -40 40])
  title('Pole-zero Map.  Best Fit.  Three Poles, One Zero') 
