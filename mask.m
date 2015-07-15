function mask(varargin)
    % units -- I'm working in mm.
    in = 25.4; % convert inches to mm
    cm = 10; % convert cm to mm
    mm = 1; % convert mm to mm
    um = 0.001; % convert microns to mm
    newline = 10; % Windows newline character
    
    % settings
    bottom_sandwich_center = [0*mm 0*mm]; % x, y
    bottom_sandwich_size = [3*in 2*in]; % length, height
    top_sandwich_size = [3*in 1*in]; % length, height
    distance_between_screws = [2.5*in 0.75*in]; % x, y
    inlet_spacing = 22*mm;
    bottom_sandwich_window_size = [15*mm, 10*mm]; % x, y
    clearance_screw_diameter = 0.25*in;
    tapped_screw_diameter = 0.2010*in;
    
    % calculate 
    top_sandwich_center = [bottom_sandwich_center(1) bottom_sandwich_center(2)+bottom_sandwich_size(2)+1*cm];
    
    
    %% Draw rectangles for the two devices
    
    info = [''];
    scr = [ erase_mask(masksize) draw_rectangles_scr zoomout()];
    
    info = ['Horowitz ' date '. McKay 530.' newline info];
    

    %% finish up and save text files
    scr = [scr zoomout()];
    
    fid = fopen(['clamp_' date '.scr'],'w');
    fprintf(fid,'%s',scr);
    fclose(fid);
    
    fid = fopen(['clamp_info_' date '.txt'],'w');
    fprintf(fid,'%s',info);
    fclose(fid);
    
    %% uncomment to display the script
    %scr
end


function o = rectangle_minus_right_side(w,h,x2,y2)
    rectangle = rect_upper_right(w,h,x2,y2);
        % inputs: width, height, x2, y2
        %   x2,y2  are the upper right corners of the rectangle
       
    % Explode rectangle and erase inner edge
    erase_side = erase_one_leg_of_object(x2,y2-h/2);
    
    o = [rectangle erase_side];
end

function o = rectangle_minus_left_side(w,h,x1,y2)
    rectangle = rect_upper_left(w,h,x1,y2);
        % inputs: width, height, x1, y1
        %   x1,y1  are the upper left corners of the rectangle
       
    % Explode rectangle and erase inner edge
    erase_side = erase_one_leg_of_object(x1,y2-h/2);
    
    o = [rectangle erase_side];
end

function o = zoom(x1,x2,y1,y2)
    o = sprintf('(command "zoom" "window" "%g,%g" "%g,%g")\n', x1,x2,y1,y2);
end

function o = erase_one_leg_of_object(x1,y1)
    a = sprintf('(command "explode" "%g,%g")\n',x1,y1);
    b = erase([x1,y1]);
    o = [a b];
end

function o = setfontarialblack(height)
    o = sprintf('(command "-STYLE" "Standard" "Arial Black" "%g" "1" "0" "n" "n")\n',height);
end

function o = setfontarial(height)
    o = sprintf('(command "-STYLE" "Standard" "Arial" "%g" "1" "0" "n" "n")\n',height);
end

function o = writecenteredtext(text,x,y)
    o = sprintf('(command "text" "Justify" "Center" "%g,%g" "0" "%s")\n',x,y,text);
end

function o = writetext(text,x,y)
    o = sprintf('(command "_text" "%g,%g" "0" "%s")\n',x,y,text);
end

% draw a circle centered at (x,y) with radius r.
function o = circ3(x,y,r)
    o = sprintf('(command "circle" "%g,%g" "%g")\n',x,y,r);
end

% inputs: width, height, x1, y1
%   x1,y1  are the lower left corners of the rectangle
% output: (command "rectangle" ".1E-2,.25E-1" "1.1E-2,.35E-1")
function o = rect3(w,h,x1,y1)
    o = sprintf('(command "rectangle" "%g,%g" "%g,%g")\n',x1,y1,x1+w,y1+h);
end

function o = arc(x1,y1,x2,y2,x3,y3)
    o = sprintf('(command "arc"  "%g,%g" "%g,%g" "%g,%g")\n', x1,y1,x2,y2,x3,y3);
end

% inputs: width, height, x2, y2
%   x2,y2  are the lower left corners of the rectangle
% output: (command "rectangle" ".1E-2,.25E-1" "1.1E-2,.35E-1")
function o = rect_upper_right(w,h,x2,y2)
    o = sprintf('(command "rectangle" "%g,%g" "%g,%g")\n',x2-w,y2-h,x2,y2);
end

% inputs: width, height, x1, y2
%   x1,y2  are the upper left corners of the rectangle
% output: (command "rectangle" ".1E-2,.25E-1" "1.1E-2,.35E-1")
function o = rect_upper_left(w,h,x1,y2)
    o = sprintf('(command "rectangle" "%g,%g" "%g,%g")\n',x1,y2-h,x1+w,y2);
end

% width, height, center x, center y
function o = rect2(w,h,varargin)
    S.pos = [0 0];
    for k=1:2:length(varargin); 
        if (isfield(S,lower(varargin{k}))); 
            S.(lower(varargin{k})) = varargin{k+1}; 
        end; 
    end;
    x = S.pos(1);
    y = S.pos(2);
    o = sprintf('(command "rectangle" "%g,%g" "%g,%g")\n',x-w/2,y-h/2,x+w/2,y+h/2);
end

% x1, y1, x2, y2  are the corners of the rectangle
% output: (command "rectangle" ".1E-2,.25E-1" "1.1E-2,.35E-1")
function o = rect4(x1,y1,x2,y2)
    o = sprintf('(command "rectangle" "%g,%g" "%g,%g")\n',x1,y1,x2,y2);
end

function o = zoomin(coords)
    zoomsize = .1;
    epsilon = .3;
    o = sprintf('(command "zoom" "window" "%g,%g" "%g,%g")\n', coords(1)-epsilon, coords(2)-epsilon, coords(1)+zoomsize+epsilon, coords(2)+zoomsize+epsilon);
end

function o = zoomout()
    o = sprintf('(command "zoom" "Extents")\n');
end

function o = erase(coords)
    a = zoomin(coords);
    b = sprintf('(command "erase" "%g,%g" "SI")\n', coords(1), coords(2));
    o = [a b zoomout];
end

function o = move_object(coords,x,y)
    o = sprintf('MOVE\n%g,%g\n\n%g,%g\n\n',coords(1),coords(2),x,y);
    %o = [zoomin(coords) o zoomout];
end

function o = erase_mask(masksize)
    epsilon = 10;
    r = masksize/2+epsilon;
    o = sprintf('ERASE\n%g,%g\n%g,%g\n\n', -r,r,r,-r);
end

% copy object using selection rectangle
% coords1 and coords2 together mark the corners of the selection rectangle
% copied object is moved by x,y (relative)
function o = copy_object(coords1,coords2,x,y)
    o = sprintf('COPY\n%g,%g\n%g,%g\n\n%g,%g\n\n',coords1(1),coords1(2),coords2(1),coords2(2),x,y);
    %o = [zoomin(coords) o zoomout];
end

function dist = distance(coordsA,coordsB)
    dist = sqrt((coordsA(1)-coordsB(1))^2 + (coordsA(2)-coordsB(2))^2);
end

function o = pickbox1()
    o = sprintf('(command "pickbox" "1")\n');
end

function o = pickbox(size)
    o = sprintf('(command "pickbox" "%g")\n',size);
end
