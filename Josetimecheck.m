%% Jose time check
dt = datetime(1578763800,'ConvertFrom','posixtime')

%% anything

% use datestr to see formated dt
datestr(dt)

% compute the posix time for the next day
et = posixtime(dt+1)

% Can't really see all of the digits unless you give the command
format long
et

% but I prefer
format compact
et

% and to print numbers the way I like
% I use formated printing with fprintf
%   first argument: 1 = print to screen
%   second argument: string with the format
%   final argument(s) are values/arrays
fprintf(1,'Epoch time is: %10.0f\n',et)

% Use the dir command to see files; dir returns a array of structures
D = dir('C:\crs\proj\2020_PEP_SSF\practice_folder')

% get the name of the first file
D(1).name

% woops...the first two files are . and .. which refer to the current
% directory and the parent directory. We can fix this by doing:
D = dir('C:\crs\proj\2020_PEP_SSF\practice_folder\*.jpg')
D(1).name

% get the time/time of the first file
D(1).date

% convert that filename to a time
% use split to divide the name into parts, using . as the delimiter.
s = split(D(1).name,'.')

% s is a cell array. In the next line, the curly brackets turn s{1} into a
% string, but datetime wants a number, so we use the str2double( ) function
% to convert the string to a double-precision number
datetime(str2double(s{1}),'ConvertFrom','posixtime')

% Why dont the times match? The time in the directory is the time the file
% was written; the time determined from the filename is the time the
% picture was triggered by he system computer.

% How can the file be written before the picture was taken? It can't. But
% the filename time is UTC (universal time coordinate, aka Greenwich Mean
% Time aka British Standard Time, which is four hours later than EST and,
% in the summer, five hours later than EDT.

% But that does not explain the discrepancy. A mystery!

%% The double %% makes this a new Matlab section, which can be run by itself
% Also, when you are in the editor, you can highlight a line or block of
% code and run it by hitting F9

% Lets loop through all of the files and see what the time difference is.
% how many images are there?
nimages = length(D)

for i = 1:nimages
    ftime(i) = datetime(D(i).date);
    s = split(D(i).name,'.');
    ptime(i) = datetime( str2double(s{1}), 'ConvertFrom','posixtime');
end

% I am not used to using the datetime object...I like datenum, which are
% just days since some reference time
ft = datenum(ftime);
pt = datenum(ptime);

%% plot the difference between the two
plot(pt,(pt-ft)*24,'.')
datetick('x')
xlabel('Time')
ylabel('Difference (hours)')
median(pt-ft)
