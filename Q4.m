%% loading
load 64channeldata.mat
channels = data;

Fs = 600;
%% not important-freq spec
% for i=1:8
%     if mod(i,8)==1
%        figure('NumberTitle', 'off','Renderer', 'painters', 'Position', [20 20 1400 500], 'Name', 'Segmented image')
% 
%     end
%     subplot(2,4,mod(i-1,8)+1)
%     
%     PlotFFT(channels(i,:,1),Fs,0);
%     xlim([0 800])
%     title("channel "+i);
%     
% end
%% filtering
load 1_75BPF

filtered_channels = channels;
for i=1:63
    for j=1:size(channels,3)
        f =  filter(Hd, channels(i,:,j));
        filtered_channels(i,:,j) = f;
    end
end

%% not important-freq spec
% for i=1:8
%     if mod(i,8)==1
%        figure('NumberTitle', 'off','Renderer', 'painters', 'Position', [20 20 1400 500], 'Name', 'Segmented image')
% 
%     end
%     subplot(2,4,mod(i-1,8)+1)
%     
%     PlotFFT(filtered_channels(i,:,1),Fs,0);
%     xlim([0 800])
%     title("channel "+i);
%     
% end
%% down sampling
Fs_ds = 150;

ds_filtered_data = zeros(63, floor(size(channels,2)*Fs_ds/Fs), size(channels,3));
for i=1:63
 
    for j=1:size(channels,3)
        channel =  filtered_channels(i,:,j);
        channel = channel(1:floor(Fs/Fs_ds):end);
        ds_filtered_data(i,:,j) = channel;
    end
end
%%
reshaped = zeros(size(ds_filtered_data, 1), size(ds_filtered_data, 2) * size(ds_filtered_data, 3));

for i=1:size(ds_filtered_data, 3)
    epoch = ds_filtered_data(:,:,i);
    
    reshaped(:,(i-1)*size(ds_filtered_data, 2)+1:(i)*size(ds_filtered_data, 2)) = epoch;
    
end

corrcoefMat = corrcoef(reshaped');

Rnk = zeros(63, 63);
