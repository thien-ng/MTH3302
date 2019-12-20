using Random

# Fonction pour split le train et test data 
function partitionTrainTest(data, at = 0.7)
    n = nrow(data)
    idx = shuffle(1:n)
    train_idx = view(idx, 1:floor(Int, at*n))
    test_idx = view(idx, (floor(Int, at*n)+1):n)
    data[train_idx,:], data[test_idx,:]
end


# Function pour remplacer les missing avec la moyenne de la ligne
# data: dataframe
# nbCol: nombre de colonnes pour la moyenne
# offset: nombre de colonnes a skip avant les donnees
function rowMean(data, nbCol, offset)
    for i = 1:size(data, 1)
        sum = 0
        for j = 1:nbCol
            if data[i,j + offset] !== missing
                sum = sum + data[i,j + offset]
            end
        end
        for j = 1:nbCol
            if data[i,j + offset] === missing
                data[i,j + offset] = floor(sum/5)
            end
        end
    end
end

# Function to normalize
function normalizeData(data, min, max)
    return (data - min) / (max - min) 
end

# Function to categorize the precip_sum
function categorizeSum(data)
    if data == 0 
        return 1
    elseif data < 50
        return 2
    elseif data < 100
        return 3
    elseif data < 150
        return 4
    elseif data < 200
        return 5
    elseif data < 250
        return 6
    elseif data < 300
        return 7
    elseif data < 350
        return 8
    elseif data < 400
        return 9
    elseif data < 450
        return 10
    elseif data < 500
        return 11
    elseif data >= 500
        return 11  
    end
end

# Function to categorize the precip_max
function categorizeMax(data)
    if data == 0 
        return 1
    elseif data < 25
        return 2
    elseif data < 50
        return 3
    elseif data < 75
        return 4
    elseif data < 100
        return 5
    elseif data < 125
        return 6
    elseif data < 150
        return 7
    elseif data < 175
        return 8
    elseif data < 200
        return 9
    elseif data >= 200
        return 10 
    end
end