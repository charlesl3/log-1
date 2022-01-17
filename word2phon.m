% Charles Liu
%11/12/2021
% usage: find the corresponding phoneme given a word index, for TIMIT test data 

[~,filePath] = CountFileType(fullfile(profile.dataset_dir, 'TIMIT/TEST'), 'wav');
filePath = filePath(endsWith(filePath, '_32000.wav')); % just the 32khz copies

phon_word_dict = {};
wordtemp = readcell(regexprep(filePath{1665}, '.WAV_32000.wav', '.WRD'), 'FileType', 'text', 'NumHeaderLines', 0, 'Delimiter', ' ');
wordtemp{11,1} = 33796;
wordtemp{11,3} = 'into';

for i = 1:numel(filePath); %in each filepath, create a cell and combine all of them
    wordtemp = readcell(regexprep(filePath{i}, '.WAV_32000.wav', '.WRD'), 'FileType', 'text', 'NumHeaderLines', 0, 'Delimiter', ' ');
    phontemp = readcell(regexprep(filePath{i}, '.WAV_32000.wav', '.PHN'), 'FileType', 'text', 'NumHeaderLines', 0, 'Delimiter', ' ');
    if i == 1665; % 1665 has some bug
        wordtemp{11,1} = 33796;
        wordtemp{11,3} = 'into';
    end

    [r,c] = size(wordtemp);
    [R,C] = size(phontemp);
    [tf,idx] = ismember(cell2mat(wordtemp(:,1)),cell2mat(phontemp(:,1)));
    index_dict = cell(5, r);

    for d = 1:r;
        index_dict{1,d} = wordtemp{d,3};
        index_dict{3,d} = d;
        index_dict{5,d} = i;
        idx_1 = find([phontemp{:,1}] == wordtemp{d,1});
        idx_2 = find([phontemp{:,2}] == wordtemp{d,2});
        
%         if d < r;
%             index_dict{2,d} = string({phontemp{idx(d):idx(d+1)-1,3}});
%             index_dict{4,d} = [idx(d):idx(d+1)-1];
%         else
%             index_dict{4,d} = [idx(d):R-1];
%             index_dict{2,d} = string({phontemp{idx(d):R-1,3}});
%         end
        index_dict{2,d} = string({phontemp{idx_1:idx_2,3}});
        index_dict{4,d} = [idx_1:idx_2];

    end
    phon_word_dict = [phon_word_dict,index_dict];
end

phon_count = []; % the total number of phoneme before the current file folder
phon_count = [phon_count; [1,0]];
count = 0;
for i = 2:numel(filePath); %in each filepath, create a cell and combine all of them
    phontemp = readcell(regexprep(filePath{i-1}, '.WAV_32000.wav', '.PHN'), 'FileType', 'text', 'NumHeaderLines', 0, 'Delimiter', ' ');
    [R,C] = size(phontemp);
    count = count + R;
    phon_count = [phon_count; [i,count]];
end

phon_word_dict_copy = phon_word_dict;
for i = 1:length(phon_word_dict_copy);
    ind = phon_count(:,1) == phon_word_dict_copy{5,i};
    phon_word_dict_copy{3,i} = phon_count(ind,2)+phon_word_dict_copy{4,i};  
end

% testing dictionary

wdidx = 14455;
phon_word_dict_copy{1:3,wdidx}
tstLabel_phon(phon_word_dict_copy{3,wdidx})



% check the total number of phonemes
% phon_count = [];
% for i = 1:numel(filePath); 
%     phontemp = readcell(regexprep(filePath{i}, '.WAV_32000.wav', '.PHN'), 'FileType', 'text', 'NumHeaderLines', 0, 'Delimiter', ' ');
%     [R,C] = size(phontemp);
%     phon_count = [phon_count; R];
% end



