function epoch = epoching(input, BackwardSamples, ForwardSamples, trigger)

k = find(trigger);
epoch = zeros(8,1,BackwardSamples+ForwardSamples+1);
trial_n = 1;

for i=1:size(k,2)
    
    if k(i)==k(mod(i,size(k,2))+1)
        continue;
    end
        
    epoch(:,trial_n,:) = input(:,round(k(i)-BackwardSamples):round(k(i)+ForwardSamples));

    trial_n = trial_n+1;
end



