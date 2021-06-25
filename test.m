global_data.Countries{1}.Region
length(global_data.Countries)

dataLength = length(global_data.Countries);
Regoins = strings;
for i = 1:length(global_data.Countries)
    if global_data.Countries{i}.Region == val
        subeRegionLength = length(global_data.Countries{i}.SubRegion);
        for j = 1:subeRegionLength
            region = global_data.Countries{i}.SubRegion
        end
    end
end