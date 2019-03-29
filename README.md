MyLake C Kuivajärvi-gtvs (2019)

Written by Petri Kiuru (petri.j.kiuru@jyu.fi)

This version of MyLake includes novel descriptions of dissolved oxygen and organic carbon (with 3 pools of DOC and 2 pools of POC) as well as a description of dissolved organic carbon species. The version is partly based on MyLake DOCOMO (see https://github.com/biogeochemistry/MyLake-v2.0 ; requires login). The model extension used in this application includes four alternative formulations for gas transfer velocity.

This version has no manual. The MyLake C model is presented in the following article:
Kiuru, P., Ojala, A., Mammarella, I., Heiskanen, J., Kämäräinen, M., Vesala, T., & Huttula, T. (2018). Effects of climate change on CO2 concentration and efflux in a humic boreal lake: A modeling study. Journal of Geophysical Research: Biogeosciences, 123, 2212–2233. https://doi.org/10.1029/2018JG004585 

MyLake_C_gases_KJ.m is a script for running the model application for Lake Kuivajärvi. The script figures_gases.m is a stand-alone script for producing related figures and additional performance statistics. The input data for the model application and the output and measurement data used in the figures are found in the folder I_O_gases. The model code for MyLake C is located in the submodules vC, vC_gases, and air_sea.
