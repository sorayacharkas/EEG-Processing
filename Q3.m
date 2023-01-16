%% loading and Fs
load subject1.mat
subject1 = SubjectData;

times = subject1(1,:);
trigger = subject1(10,:);
T = mean(diff(times));
Fs = 1/T;


%% freq spec
for i=1:8
    subplot(2,4,i)
    
    PlotFFT(subject1(i+1,:),Fs,0);
    xlim([0 65])
    title("channel "+i);
    
end

%% filtering
filtered_data = subject1(2:9,:);
load 1_40BPF
for i=1:8
   channel = filtered_data(i,:);
   channel = channel - mean(channel);
   filtered_data(i,:) = filter(Hd, channel);
end


%%  down sampling
Fs_ds = 80;

times_ds = times(1:floor(Fs/Fs_ds):end);
ds_trigger = trigger(1:floor(Fs/Fs_ds):end);
ds_filtered_data = zeros(8,size(times_ds,2));
for i=1:8
   channel = filtered_data(i,:);
   channel = channel(1:floor(Fs/Fs_ds):end);
   ds_filtered_data(i,:) = channel;
end

%% epoch
tic;
epoch = epoching(ds_filtered_data, Fs*0.2, Fs*0.8, ds_trigger);
toc;

%%

