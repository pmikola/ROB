function [tlab, tvec] = readmnist(datafn, labelfn)
% function reads mnist data and labels 

fid = fopen(datafn, 'rb');
# open datafn in read and big-endian format.
# returns a file-id
if fid==-1
   error('Error opening data file');
end;

fseek(fid, 0, 'eof');
# Seek to the 0th byte from the end of the file.
# In other words. Just go to the end of the file.
# fid == the file to be accessed.
# 'eof' == relative position.
# 0 == bytes to be read.

cnt = (ftell(fid) - 16)/784;
cnt = int64(cnt)
fseek(fid, 16, 'bof');
# Move to the 16th byte from the beginning of file.
tvec = zeros(cnt, 784);
# returns a 2D cntx784 matrix of zeros.

for i=1:cnt
   im = fread(fid, 784, 'uchar');
   tvec(i,:) = (im(:)/255.0)';
end;
fclose(fid);
cnt

fid = fopen(labelfn, 'rb');
if fid==-1
   error('Error opening label file');
end;
fseek(fid, 8, 'bof');
[tlab nel] = fread(fid, cnt, 'uchar');
if nel ~= cnt 
   disp('Not all elements read.');
end;
fclose(fid);
nel