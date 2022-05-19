function pdf-remove-blank-pages
set input_file $argv[1]
set output_file (string split '_' $input_file)[1]".pdf"
pdftk A=$input_file cat Aodd output $output_file
end
