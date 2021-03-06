FROM rocker/shiny-verse:3.5.1

RUN apt-get -y install libjpeg-dev

RUN install2.r cowplot \
	gginnards \
	ggmap \
	ggthemes \
	ggpmisc \
	ggrepel \
	ggseqlogo \
	leaflet \
	magrittr \ 
	msaR \
	plyr \
	RColorBrewer \
	reshape2 \
	shinyBS \
	shinycssloaders \
	shinythemes \
	stringr \
	BiocManager

# Install difficult BioC packages
RUN R -e 'devtools::install_github("knausb/vcfR")'

RUN R -e 'BiocManager::install("VariantAnnotation")'

# Setup an R script to install bioconductor packages
ADD install.R /tmp/

# invalidates cache every 24 hours
ADD http://master.bioconductor.org/todays-date /tmp/

# Install bioMart, VariantAnnotation and vcfR
RUN R -f /tmp/install.R

# Install r1001genomes from github repo
RUN R -e 'devtools::install_github("wrightrc/r1001genomes", ref = "docker-stable")'

COPY mountpoints/apps/ /srv/shiny-server/

CMD ["/usr/bin/shiny-server.sh"]