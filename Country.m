classdef Country
    properties
        Region
        SubRegion = []
        Cases
        Deaths
        CasesDaily
        DeathsDaily
    end
    
    methods
        function obj = Country(region, data, i)      
            n = size(data);
            si = 1;
            obj.Region = region;
            
            for jj = 3:n(2)
                obj.Cases(jj-2) = data{i, jj}(1);
                obj.Deaths(jj-2) = data{i, jj}(2);
            end
            
            obj.CasesDaily(1) = obj.Cases(1);
            obj.DeathsDaily(1) = obj.Deaths(1);
            for jj = 3:n(2)-1
                obj.CasesDaily(jj-1) = obj.Cases(jj-1) - obj.Cases(jj-2);
                obj.DeathsDaily(jj-1) = obj.Deaths(jj-1) - obj.Deaths(jj-2);
                
                %%setting negative values to 0
                if obj.CasesDaily(jj - 1) < 0
                    obj.CasesDaily(jj - 1) = 0;
                end
                if obj.DeathsDaily(jj - 1) < 0
                    obj.DeathsDaily(jj - 1) = 0;
                end
            end
            if i == n(1)
                return;
            end
            if ~(region == string(data{i+1,2}))
                while (~isempty(data{i+1,2})) && (string(data{i+1,1}) == region)
                    obj.SubRegion{si} = Country(string(data{i+1,2}), data, i+1);
                    si = si + 1;
                    i = i + 1;
                end
            end

        end
    end
end