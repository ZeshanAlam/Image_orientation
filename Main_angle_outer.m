function angle = Main_angle_outer(disp)
    % Determine the size of the input image
    [m, n] = size(disp);
    
    % Adjust image size to make it square based on the larger dimension
    if m > n
        disp = imresize(disp, [m, m]);
    elseif n > m
        disp = imresize(disp, [n, n]);
    end
    
    % Get the new dimensions of the image
    [w, h] = size(disp);
    
    % Initialize a masked image and a magnitude vector
    masked = zeros(w, h);
    mag = zeros(1, 4);
    
    % Loop through four orientations to calculate the gradient magnitude
    for i = 1:4
        % Copy the original image to the masked image
        masked(:, :) = disp(:, :);
        
        % Apply masking based on the current orientation
        if i == 1
            masked(1:floor(w / 2), :) = 0;
            mag(i) = sum(masked, 'all');
        elseif i == 2
            masked(floor(w / 2) + 1:end, :) = 0;
            mag(i) = sum(masked, 'all');
        elseif i == 3
            masked(:, 1:floor(w / 2)) = 0;
            mag(i) = sum(masked, 'all');
        elseif i == 4
            masked(:, floor(w / 2) + 1:end) = 0;
            mag(i) = sum(masked, 'all');
        end
    end
    
    % Initialize a test vector to compare magnitudes
    test = mag;
    
    % Determine the predominant angle based on the gradient magnitude
    angle = 0; % Default angle
    test(1) = 0;
    if all(mag(1) > test)
        angle = 0;
    end
    
    test = mag;
    test(2) = 0;
    if all(mag(2) > test)
        angle = 180;
    end
    
    test = mag;
    test(3) = 0;
    if all(mag(3) > test)
        angle = 90;
    end
    
    test = mag;
    test(4) = 0;
    if all(mag(4) > test)
        angle = 270;
    end
end

