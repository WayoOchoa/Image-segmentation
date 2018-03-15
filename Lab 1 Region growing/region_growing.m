function [new_image,number_regions] = region_growing(image,threshold,connectivity)
    % Checkin the number of inputs of the function and assigning default
    % values
    if nargin>3 %Checks the number of inputs
        error('To many parameters in the input. Requires at most 3 parameters');
    end
    switch nargin % Assigning the default parameters
        case 1
            threshold = 50;
            connectivity = 4;
        case 2
            connectivity = 4;
    end
    
    % Creating the connectivity list
    switch connectivity
        case 4
            connectivity = [-1 0; 0 1; 1 0; 0 -1]; %4 pixels connectivity mask
        case 8
            connectivity = [-1 -1; -1 0; -1 1; 0 1; %8 pixels connectivity mask
            1 1; 1 0; 1 -1; 0 -1];
    end
    
    % Checking the type of the image (grayscale or RGB)
    % Flag_rgb is used to know with type of image we are using (RGB or
    % grayscale)
    if size(image,3)==3
        flag_rgb = 1;
    else
        flag_rgb = 0;
    end
    
    % Initializing the region algorithm
    R = 1; % Region number assignment
    number_regions = 0;
    new_image = zeros(size(image,1),size(image,2));
    queue = [1 1];
    
    % Start of the region growing. It stops when there is no unassigned
    % pixels on the new image, that means all pixels belongs to a region
    while find(new_image==0,1)~=0
        new_image(queue(1),queue(2)) = R; % assigning the value of the new region been created
        number_pixels = 1; % counter to calculate the mean of the pixels that have been taken
        switch flag_rgb
            case 0
                mean_value = image(queue(1),queue(2)); % Current mean value
            case 1 % RGB image depends on the distance of the pixels
                mean_rgb = image(queue(1),queue(2),:);
        end
    
    % Current region R assignation
        while size(queue,1) ~=0
            for k = 1:size(connectivity,1)
                actual_pixel = queue(1,:) + connectivity(k,:);

                % Checking that is on the boundaries of the image
                if min(actual_pixel)<1
                    continue
                elseif actual_pixel(1)>size(image,1)
                    continue
                elseif actual_pixel(2)>size(image,2)
                    continue
                end

                % Checking that the pixel hasn't been asigned
                if new_image(actual_pixel(1),actual_pixel(2))~=0
                    continue
                end
                
                % Checking if the actual pixel intensity enters in the current region
                switch flag_rgb
                    case 0 % Gray scale image case
                        if abs(image(actual_pixel(1),actual_pixel(2))-mean_value)<= threshold % Comparing the intensity with the mean value of the region
                            new_image(actual_pixel(1),actual_pixel(2)) = R; % Adding the pixel to the image
                            queue(size(queue,1)+1,:) = actual_pixel; % Adding the neighbor to the queue for exploring neighbors later
                            mean_value = (mean_value*number_pixels + image(actual_pixel(1),actual_pixel(2)))/(number_pixels+1); % Updating the mean of the region
                            number_pixels = number_pixels+1;
                        else
                            continue
                        end
                    case 1 % RGB image case
                        if abs(sqrt(sum((mean_rgb-image(actual_pixel(1),actual_pixel(2),:)).^2)))<= threshold % Comparing the distance between mean features
                            new_image(actual_pixel(1),actual_pixel(2)) = R;
                            queue(size(queue,1)+1,:) = actual_pixel;
                            mean_rgb = ((mean_rgb).*number_pixels + image(actual_pixel(1),actual_pixel(2),:))./(number_pixels+1); % Updating the mean vector of the region
                            number_pixels = number_pixels+1;
                        else
                            continue
                        end
                end
            end
            queue = queue(2:end,:); % updating the queue
        end
        [x,y] = find(new_image'==0); % finding the next pixel that has not been assigned after
                                    % one region has stopped
%         [x,xSort] = sort(x);
%         y = y(xSort);
        R = R+1; % Defining the new region label
        number_regions = number_regions + 1; 
        if size(x,1)==0 || size(y,1)==0
            break
        else
            queue = [y(1) x(1)]; % Re-initializing the queue for the ith Region
        end
    end
end