function hex8dump(fileinput, fileoutput, ncols)
% hex8dump(filenm, n, ncols)
% Write the content of the binary file 'fileinput' in ASCII and 1-byte long hex form into 
% 'fileoutput' with 'ncols' columns.
fip = fopen(fileinput, 'r');
fop = fopen(fileoutput, 'w+');
if (fip<0), disp(['Error opening ',fileinput]); return; end
[A,count] = fread(fip, ncols, '*uchar');
colwidth = max(2,ceil(log(ncols)/log(16)));
address = 0;
fprintf(fop, '%s %s\n', 'Address         ', sprintf(['% ',num2str(colwidth),'x '],0:ncols-1));
while 1
    if count==0
        fprintf(fop, '');
        break
    end
    hexstring = repmat(' ',1, (colwidth+1)*ncols);
    hexstring(1:(colwidth+1)*count) = sprintf(['% ',num2str(colwidth),'x '],A);
    ascstring = repmat('.',1, ncols);
    idx = find(double(A)>=32);
    ascstring(idx) = char(A(idx));
    fprintf(fop, '%s %s |%s|', sprintf('%016x',address), hexstring, ascstring);
    if count<ncols
        break
    else
        [A,count] = fread(fip, ncols, '*uchar');
        if count==0
            break
        else
            fprintf(fop, '\n');
        end
    end
    address = address + ncols;
end
fclose(fip);
fclose(fop);