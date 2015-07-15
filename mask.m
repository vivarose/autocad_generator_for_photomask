function mask(varargin)
    % units -- I'm working in microns.
    in = 25400; % convert inches to um
    cm = 10000; % convert cm to um
    mm = 1000; % convert mm to um
    um = 1; % convert microns to um
    newline = 10; % Windows newline character
    
    % settings
    masksize = 3.8*cm;
    textheight = 1.5*mm;
    textspacing = 1*mm + textheight; % distance between bottom of square and bottom of text
    %relative_center_y_top_row = chipsize-1*mm-(2500*um)/2; % measured from bottom of chip
    %do_hatch = false;
    
    %% Draw circle for the chip
    diam = masksize;
    circle_scr = circ3(0,0,diam/2);
    info = ['Wafer diameter is ' num2str(diam/mm) ' mm.' newline];
    scr = [ erase_mask(masksize) circle_scr zoomout()];
    
    %% Label wafer with name and date
    o = setfontarialblack(1*mm);
    text_y = -12000*um;
    p = writecenteredtext(['Horowitz ' date], 0, text_y); % name, date
    p2 = writecenteredtext('McKay 530', 0, text_y-1.6*mm); % room number
    scr = [scr o p p2];
    info = ['Horowitz ' date '. McKay 530.' newline info];
    clear o p
    
    %% Specify chamber:
    x = -1500*um; % center
    y = 8200*um;  % center
    num_chambers = 1;
    label = false;
    chamber_diam = 650*um;
    width_of_spacer = 125*um;
    width_of_channel = 250*um;
    inlet_spacing = 22*mm;
    
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label
    
    %% Specify chamber:
    x = -2200*um; % center
    y = -8000*um;  % center
    num_chambers = 5;
    label = true;
    chamber_diam = 10*um;
    width_of_spacer = 125*um;
    width_of_channel = 250*um;
    
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label

    %% Specify chamber:
    x = 1000*um; % center
    y = 4500*um;  % center
    num_chambers = 2;
    label = true;
    chamber_diam = 2*650*um;
    width_of_spacer = 125*um;
    width_of_channel = 300*um;
    
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label

    %% Specify chamber:
    x = 1000*um; % center
    y = -4000*um;  % center
    num_chambers = 1;
    label = false;
    chamber_diam = 3*650*um;
    width_of_spacer = 125*um;
    width_of_channel = 300*um;
   
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label

    %% Specify chamber:
    x = -4500*um; % center
    y = 300*um;  % center
    num_chambers = 12;
    label = true;
    chamber_diam = 50*um;
    width_of_spacer = 125*um;
    width_of_channel = 250*um;
    
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label

    %% Specify chamber:
    x = -1000*um; % center
    y = 11500*um;  % center
    num_chambers = 4;
    label = true;
    chamber_diam = 20*um;
    width_of_spacer = 125*um;
    width_of_channel = 250*um;
    
    % draw a chamber with one input
    [o, device_width] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing,num_chambers, label);
    scr = [scr o];
    newinfo = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline);
    info = [info newinfo];
    clear x y chamber_diam width_of_spacer width_of_channel newinfo num_chambers o device_width label

    %% finish up and save text files
    scr = [scr zoomout()];
    
    fid = fopen(['mymask_' date '.scr'],'w');
    fprintf(fid,'%s',scr);
    fclose(fid);
    
    fid = fopen(['mymask_info_' date '.txt'],'w');
    fprintf(fid,'%s',info);
    fclose(fid);
    
    %% uncomment to display the script
    %scr
end

function info = infostring(x,y,chamber_diam,width_of_spacer,width_of_channel,num_chambers,inlet_spacing,device_width,newline)
% sample text:
%  1 chamber at (-1500,8200) has diameter 650 um, width_of_spacer=125 um, width_of_channel=250 um.
    mm = 1000;

    if num_chambers > 1
        text1 = ' chambers with first at (';
        text2 = ') each have diameter ';
    else
        text1 = ' chamber at (';
        text2 = ') has diameter ';
    end
    info = [num2str(num_chambers) text1 num2str(x) ',' num2str(y) text2 num2str(chamber_diam) ' um, width_of_spacer=' num2str(width_of_spacer) ' um, width_of_channel=' num2str(width_of_channel) ' um. Device width without channels is ' num2str(device_width/mm) ' mm. Inlet spacing is ' num2str(inlet_spacing/mm) ' mm.'  newline];
end

function [arc_left_x,arc_right_x,top_arc_y,outer_circle_radius,o] = draw_chamber(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing)
    % Calculations for chamber
    outer_circle_radius = chamber_diam/2 + width_of_spacer + width_of_channel;
    
    % Draw chamber
    zoom_scr = zoom(x-outer_circle_radius, x+outer_circle_radius,y-outer_circle_radius,y+outer_circle_radius);
    chamber_scr = circ3(x,y,chamber_diam/2);
    spacer_scr = circ3(x,y,chamber_diam/2 + width_of_spacer);

    % Calculate arc for channel with one input and one output
    arc_y = y-width_of_channel/2;
    top_arc_y = y+width_of_channel/2;
    arc_left_x = -sqrt(outer_circle_radius^2 - (arc_y - y)^2) +x;
    arc_right_x = sqrt(outer_circle_radius^2 - (arc_y - y)^2) +x;
    arc_center_y = y-outer_circle_radius;
    top_arc_center_y = y+outer_circle_radius;

    % Draw arc for channel
    bottom_arc_scr = arc(arc_left_x,arc_y,x,arc_center_y,arc_right_x,arc_y);
    top_arc_scr = arc(arc_left_x,top_arc_y,x,top_arc_center_y,arc_right_x,top_arc_y);
    
    o = [ zoom_scr chamber_scr spacer_scr bottom_arc_scr top_arc_scr zoomout() ];

end



function [o,width_of_device_without_channels] = draw_chamber_with_input_output(x,y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing, num_chambers, label)   
    um = 1;
    outlet_diameter = 775*um;

    this_x = x;
    this_y = y;
	label_height = 100*um;
	font_scr = setfontarial(label_height);
	chamber_scr = [font_scr];

    for i=1:num_chambers
        [this_arc_left_x,this_arc_right_x,top_arc_y,outer_circle_radius,this_chamber_scr] = draw_chamber(this_x,this_y, chamber_diam,width_of_spacer, width_of_channel, inlet_spacing);
        if i == 1
            arc_left_x = this_arc_left_x;
        end
        
        if label
            label_scr = writecenteredtext(num2str(i), this_x, this_y-outer_circle_radius-width_of_channel-label_height); 
            this_chamber_scr = [this_chamber_scr  label_scr];
        end
        
        % advance to the next chamber
        this_x = this_arc_right_x+(this_arc_right_x-this_x);

        chamber_scr = [chamber_scr this_chamber_scr];
    end
    arc_right_x = this_arc_right_x;
    clear this_x this_y
    
    width_of_device_without_channels = arc_right_x - arc_left_x;
    center_of_device_x = (arc_right_x + arc_left_x)/2;
    
    % use pythagorean theorem to figure out how long the channels need to be
    inlet_subradius = sqrt((outlet_diameter/2)^2 - (width_of_channel/2)^2);
    % inlet_spacing = inlet_subradius * 2 + channel_length * 2 + width_of_device_without_channels
    channel_length = (inlet_spacing-2*inlet_subradius-width_of_device_without_channels)/2;

    % Draw rectangles for channel with one input and one output
    channel_left_scr = rectangle_minus_right_side(channel_length, width_of_channel, arc_left_x, top_arc_y);
    channel_right_scr = rectangle_minus_left_side(channel_length, width_of_channel, arc_right_x,top_arc_y);
    
    a = [channel_left_scr channel_right_scr ];
    
    % calculate outlet_center_coords
    left_outlet_center_coords = [center_of_device_x-inlet_spacing/2 y];
    right_outlet_center_coords = [center_of_device_x+inlet_spacing/2 y];
    
    % left "outlet" (it doesn't need a filter)
    top_of_channel_coords = [arc_left_x-channel_length,top_arc_y];
    bottom_of_channel_coords = [arc_left_x-channel_length,top_arc_y-width_of_channel];
    b = draw_short_outlet(left_outlet_center_coords,top_of_channel_coords,bottom_of_channel_coords, true);
    clear top_of_channel_coords  bottom_of_channel_coords
    
    % right outlet
    top_of_channel_coords = [arc_right_x + channel_length, top_arc_y];
    bottom_of_channel_coords = [arc_right_x + channel_length,top_arc_y-width_of_channel];
    c = draw_short_outlet(right_outlet_center_coords,top_of_channel_coords,bottom_of_channel_coords, false);
    clear top_of_channel_coords  bottom_of_channel_coords
    
    o = [a chamber_scr b c];
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

% % I have a microfluidic outlet at a particular location and I can copy it
% % from there and put it at any location.
% function o = copy_outlet(coords)
%     copy_object([24500,2010],[27550,-569],
% end

% Draw an outlet attached to a channel. Top of channel and bottom of
% channel coordinates are inputs. "left" is a boolean input that is true if
% the outlet is to the left of the channel and falst if the outlet is to
% the right of the channel.
function o = draw_long_outlet(top_of_channel_coords,bottom_of_channel_coords, left)
    um = 1;
    
    outlet_height = 775*um;
    outlet_straight_width = 1020*um;
    outlet_distance_from_channel = 525*um;
    outlet_radius_of_curvature = 360*um;
    
    center_of_channel_coords = [(top_of_channel_coords(1)+bottom_of_channel_coords(1))/2,(top_of_channel_coords(2)+bottom_of_channel_coords(2))/2];
    a = erase(center_of_channel_coords);
    
    
    if left
        point2x = top_of_channel_coords(1)-outlet_distance_from_channel;
        point3x = point2x - outlet_straight_width;
        endpointx = point3x - outlet_radius_of_curvature;
    else
        point2x = top_of_channel_coords(1)+outlet_distance_from_channel;
        point3x = point2x + outlet_straight_width;
        endpointx = point3x + outlet_radius_of_curvature;
    end
    point2y = center_of_channel_coords(2)+outlet_height/2;
    point4y = center_of_channel_coords(2)-outlet_height/2;
    point4x = point3x; % assume horizontal channel
    point5x = point2x; % assume horizontal channel
    point3y = point2y; % assume horizontal channel
    point5y = point4y; % assume horizontal channel
    endpointy = center_of_channel_coords(2); % assume horizontal channel
    
    
    % draw top of inlet
    b = sprintf('(command "line" "%g,%g" "%g,%g" "%g,%g")\n\n',top_of_channel_coords(1),top_of_channel_coords(2), point2x,point2y, point3x,point3y);
    c = sprintf('(command "line" "%g,%g" "%g,%g" "%g,%g")\n\n',bottom_of_channel_coords(1),bottom_of_channel_coords(2), point5x,point5y, point4x,point4y);
    d = arc(point3x,point3y, endpointx,endpointy,point4x,point4y);
    
    % copy crown
    clear coords1 coords2 from_coords x y
    if left
        coords1 = [24000,7400];
        coords2 = [27000,4000];
        from_coords = [26043,5737];
    else
        coords1 = [32000,700];
        coords2 = [34000,-1200];
        from_coords = [33275,-294];
    end
    x = endpointx - from_coords(1);
    y = endpointy - from_coords(2);
    
    f = copy_object(coords1,coords2,x,y);
    clear coords1 coords2 from_coords x y
    
    o = [a b c d f];
end

function dist = distance(coordsA,coordsB)
    dist = sqrt((coordsA(1)-coordsB(1))^2 + (coordsA(2)-coordsB(2))^2);
end

function o = draw_short_outlet(outlet_center_coords,top_of_channel_coords,bottom_of_channel_coords, left)
    
    outlet_radius_of_curvature = distance(outlet_center_coords, top_of_channel_coords);
    
    center_of_channel_coords = [(top_of_channel_coords(1)+bottom_of_channel_coords(1))/2,(top_of_channel_coords(2)+bottom_of_channel_coords(2))/2];
    a = erase(center_of_channel_coords);
    endpointy = center_of_channel_coords(2);
    
    % assuming horizontal outlet
    if left
        endpointx = outlet_center_coords(1) - outlet_radius_of_curvature;
    else
        endpointx = outlet_center_coords(1) + outlet_radius_of_curvature;
    end
  
    % draw circular outlet
     d = arc(top_of_channel_coords(1),top_of_channel_coords(2), endpointx,endpointy,bottom_of_channel_coords(1),bottom_of_channel_coords(2));
    
    % copy crown
    clear coords1 coords2 from_coords x y
    if left % I have a crown located at a specific location on my autocad drawing
        coords1 = [24000,7400];
        coords2 = [27000,4000];
        from_coords = [26043,5737];
    else
        coords1 = [32000,700];
        coords2 = [34000,-1200];
        from_coords = [33255,-294];
    end
    x = endpointx - from_coords(1);
    y = endpointy - from_coords(2);
    
    f = copy_object(coords1,coords2,x,y);
    clear coords1 coords2 from_coords x y
    
    o = [a d f];
end

function o = pickbox1()
    o = sprintf('(command "pickbox" "1")\n');
end

function o = pickbox(size)
    o = sprintf('(command "pickbox" "%g")\n',size);
end
