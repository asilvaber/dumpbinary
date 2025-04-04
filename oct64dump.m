function oct64dump(fileinput, fileoutput, ncols)
% oct64dump(filenm, n, ncols)
% Write the content of the binary file 'fileinput' in 8-byte octal int form into 
% 'fileoutput' with 'ncols' columns.
fip = fopen(fileinput, 'r');
fop = fopen(fileoutput, 'w+');
if (fip<0), disp(['Error opening ',fileinput]); return; end
[A,count] = fread(fip, ncols, '*uint64');
while 1
    if count==0
        fprintf(fop, '');
        break
    end
    hexstring = sprintf('%022o ',A);
    fprintf(fop, '%s', hexstring);
    if count<ncols
        break
    else
        [A,count] = fread(fip, ncols, '*uint64');
        if count==0
            break
        else
            fprintf(fop, '\n');
        end
    end
end
fclose(fip);
fclose(fop);