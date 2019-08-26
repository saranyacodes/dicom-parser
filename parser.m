%% the following block of code is for user input questions 

prompt1 = ['Please enter the path to the folder like so '...
    '(/Users/saranya/wherever the folder is ...), not including the '...
    'folder name at the end'];
folder_path = input(prompt1, 's');
disp(strcat("You entered ", folder_path)); 

if ~exist(folder_path, 'dir')
    disp('The folder path does not exist. Exited the program.'); 
    return;  
end 

prompt2 = 'Please enter the actual folder name: '; 
folder_name = input(prompt2, 's'); 
disp(strcat("You entered ", folder_name)); 


if ~exist(strcat(folder_path, '/', folder_name), 'dir')
    disp('The folder name does not exist. Exited the program.'); 
    return;  
end 

new_folder_name = strcat('new_', folder_name); 
prompt3 = strcat('This program will now find the ', folder_name, ...
' folder and create DICOM files from it, and create a new folder for ', ...
'this titled ', new_folder_name, ' .Yes or no?: '); 

yes_no = input(prompt3, 's'); 
disp(strcat("You entered ", yes_no)); 


lower_yes_no = lower(yes_no); 
if strcmp(lower_yes_no, 'yes')
    %% the following block of code is for actual execution 
    
    %now we want to use the folder_path and the folder_name to create a new
    %folder to exist in that directory
    new_dir = strcat(folder_path, '/', new_folder_name); 
    if exist(new_dir, 'dir')
        disp(strcat('The folder ', new_folder_name, ' already exists.', ...
        ' Exiting the program.' )); 
        return; 
    end 
    
    
    mkdir(new_dir); 
    
    %we want to go through each file in the folder_path/folder_name and do
    %operations to each of those files and then save them
    %this gives a list of the files in the folder 
    files = dir(strcat(folder_path, '/', folder_name)); 
    
    
    %disable the warnings 
    warning off;
    
    %start at 3
    counter = 0; 
    for i = 3:length(files) 
        current = files(i).name;
        
        current_path = strcat(folder_path, '/', folder_name, '/', current); 
        info = dicominfo(current_path); 
        pixelarray = dicomread(current_path);
        
        %convert into standard int16 hounsfield values 
        new_pixelarray = int16(pixelarray) * info.RescaleSlope + info.RescaleIntercept;
        
        %do some operation to the new_pixelarray (this inverts colors)
        new_pixelarray = new_pixelarray * -1;
        
        new_filename = strcat('new_', current); 
        new_pixelarray = new_pixelarray / info.RescaleSlope - info.RescaleIntercept;
        new_pixelarray = uint16(new_pixelarray); 

        dicomwrite(new_pixelarray, strcat(new_dir, '/', new_filename),... 
        info);
    
        counter = counter + 1; 
        if mod(counter, 5) == 0
            disp(strcat(num2str(counter), " files finished processing...")); 
        end 
     
    end 
    disp('Files are created! Done.'); 
    

else
    disp('You said no. Program exited.'); 
    return;
end 




