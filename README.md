The codes are organised in four modules (data_extraction, quality_control, validation_and_visualization, file_generation), with each saved in one folder.

The data_extraction module is to extract the original data from the raw datasets and perform location check and time reversal check. Users are suggested to run scripts following the order marked  in filename suffixes, e.g., Argo_extract2.m file should be executed directly after Argo_extract1.m file.  Please note that manual operations during database construction, e.g., moving data from one file to another file, are not included in this module.

The quality_control module follows a sequential workflow, i.e., depth check, constant value check, value range check, and vertical gradient check, as described in the manuscript.

The validation_and_visualization module includes: the visualization of depth check result (Depth_check_plot.m), the visualization of value range check result (Value_range_check_plot1.m), the visualization of outliers distribution in value range check result (Value_range_check_plot2.m), the visualization of vertical gradient check result (Value_gradient_check_plot.m). MGV.mat is called in Value_gradient_check_plot.m and Value_gradient_check.m files. 

The file_generation module is to produce the 12 NetCDF files for data storage. 

For clarification on code implementation, please contact the authors via email: bei.su@sdu.edu.cn or cecewang@mail.sdu.edu.cn
