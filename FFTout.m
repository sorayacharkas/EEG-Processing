function out = FFTout(InputSignal, Fs)
    SignalFFT = fft(InputSignal); %n-point dft
    a = 1;
    L = length(InputSignal);
    AbsSignal = abs(SignalFFT/L);
    FinalSignal = AbsSignal(1:floor(L*a));
    FinalSignal(2:end-1) = 2*FinalSignal(2:end-1);
	f = Fs*(0:floor(L*a)-1)/L;
    w = 2 * pi * f / Fs;
    out = FinalSignal(1:floor(L/2));
end