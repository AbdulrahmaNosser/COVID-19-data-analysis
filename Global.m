classdef Global
    properties
        Countries
        Dates
        Cases
        Deaths
        CasesDaily
        DeathsDaily
    end
    
    methods
        function obj = Global(data)
            n = size(data);
            j = 2;
            dataSize = n(2) - 2;

            obj.Dates = datetime(data(1,3:end),'InputFormat','MM/dd/yy');
            obj.Cases = zeros(1, dataSize);
            obj.Deaths = zeros(1, dataSize);
            obj.CasesDaily = zeros(1, dataSize);
            obj.DeathsDaily = zeros(1, dataSize);
            obj.Countries{1} = Country(string(data{2,1}), data, 1);
            
            for i = 2:n(1)
                
                if obj.Countries{j-1}.Region ~= string(data{i,1})
                    obj.Countries{j} = Country(string(data{i,1}), data, i);
                    j = j+1;
                    
                    for k = 3:n(2)
                        obj.Cases(k - 2) = obj.Cases(k - 2) + data{i, k}(1);
                        obj.Deaths(k - 2) = obj.Deaths(k - 2) + data{i, k}(2);
                    end
                    
                    obj.CasesDaily(1) = obj.Cases(1);
                    obj.DeathsDaily(1) = obj.Deaths(1);
                    for k = 2:dataSize
                        obj.CasesDaily(k) = obj.Cases(k) - obj.Cases(k - 1);
                        obj.DeathsDaily(k) = obj.Deaths(k) - obj.Deaths(k - 1);
                        
                        %%setting negative values to 0
                        if obj.CasesDaily(k) < 0
                            obj.CasesDaily(k) = 0;
                        end
                        if obj.DeathsDaily(k) < 0
                            obj.DeathsDaily(k) = 0;
                        end
                    end
                end
                
                if i > n(1)
                    break;
                end
            end
        end
    end
end