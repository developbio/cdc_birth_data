# At least on WSL, you must install these for the R animation packages to work 
# See: https://github.com/datacarpentry/r-raster-vector-geospatial/issues/138 and https://stackoverflow.com/questions/12141422/error-gdal-config-not-found 
# sudo apt-get upgrade
sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev
# To render the gifs, you'll need to install "gifski" in R. This requires having Rust/Cargo.
sudo apt-get install cargo
