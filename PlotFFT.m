function PlotFFT(InputSignal, Fs, Flag)
    SignalFFT = fft(InputSignal); %n-point dft
    a = 1;
    L = length(InputSignal);
    AbsSignal = abs(SignalFFT/L);
    FinalSignal = AbsSignal(1:floor(L*a));
    FinalSignal(2:end-1) = 2*FinalSignal(2:end-1);
	f = Fs*(0:floor(L*a)-1)/L;
    w = 2 * pi * f / Fs;
    if Flag == 1
        plot(w,FinalSignal,'linewidth',1.5);
        xlabel('w (rad/s)'); ylabel('|H(f)|');
        xlim([0 2*pi/a]); grid minor;
        set(gca,'XTick',0:pi/4:2*pi/a);
        set(gca,'XTickLabel',{'0','\pi/4','\pi/2','3\pi/4','\pi','5\pi/4','3\pi/2','7\pi/4','2\pi'});
    else
        plot(f(1:floor(L/2)),FinalSignal(1:floor(L/2)),'linewidth',1.5);
        disp(floor(L/2));

      
        xlabel('f (Hz)'); ylabel('|H(f)|');
        xlim([0,f(floor(L/2))]); grid minor;
    end
end