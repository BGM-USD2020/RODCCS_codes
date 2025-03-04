Code Description​:
The code comprises four modules with each module in one folder, i.e., ​data_extraction, ​quality_control, ​validation_and_visualization, and ​file_generation.
The ​data_extraction module​ is to extract the variables included in RODCCS from the raw data, and also includes codes for quality control of ​location check and ​time reversal check. Note that certain manual operations during database construction are not included in the code. Script execution follows the numerical order indicated in filename suffixes (e.g., Argo_extract1.m, Argo_extract2.m).
The ​quality_control module​ follows a sequential workflow of ​depth check, ​constant value check, ​value range check, and ​vertical gradient check.
The ​validation_and_visualization module​ includes: Depth_check_plot.m for result of depth check visualization, Value_range_check_plot1.m for result of value range check visualization, Value_range_check_plot2.m for detailed subplot generation of value range check, Vertical_gradient_check_plot.m, which relies on MGV.mat and six additional gradient-related files.
The ​file generation module​ produces 12 NetCDF files. 
For clarification on script execution or code implementation, please contact the authors via email: bei.su@sdu.edu.cn
