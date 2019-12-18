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