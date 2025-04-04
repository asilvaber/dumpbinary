function uint8dump(fileinput, fileoutput, ncols)
% uint8dump(filenm, n, ncols)
% Write the content of the binary file 'fileinput' in ASCII and in 1-byte long unsigned int form into 
% 'fileoutput' with 'ncols' columns.
fip = fopen(fileinput, 'r');
fop = fopen(fileoutput, 'w+');
if (fip<0), disp(['Error opening ',fileinput]); return; end
[A,count] = fread(fip, ncols, '*uint8');
while 1
    if count==0
        fprintf(fop, '');
        break
    end
    hexstring = repmat(' ',1, 4*ncols);
    hexstring(1:4*count) = sprintf('% 3u ',A);
    ascstring = repmat('.',1, ncols);
    idx = find(double(A)>=32);
    ascstring(idx) = char(A(idx));
    fprintf(fop, '%s *%s*', hexstring, ascstring);
    if count<ncols
        break
    else
        [A,count] = fread(fip, ncols, '*uint8');
        if count==0
            break
        else
            fprintf(fop, '\n');
        end
    end
end
fclose(fip);
fclose(fop);