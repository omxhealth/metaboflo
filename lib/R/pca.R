############################################################
# 
# Run PCA Analysis on a data set.
#
# Data format: 
# ID column labelled "subjectID"
# Label column labelled "Label" (Currently works best for 2 labels)
# Remaining data should be real-valued
# 
############################################################

debug = FALSE

#Run PCA
plot.pca = function(orig_data, label.points=TRUE) {
	
	#Get IDs and Labels
	ids = orig_data$subjectID
	Labels = orig_data$Label

	classes = levels(as.factor(Labels))

	#Remove ID & Label from data matrix:
	data = orig_data[,-match('subjectID', names(orig_data))]
	data = data[,-match('Label', names(data))]

	#Run PCA:
	data[is.na(data)] = 0
	pca = prcomp(data)#na.action=na.exclude, center=TRUE, scale=TRUE)
	#pca = princomp(data) #Alternative method

	x_points = pca$x[,1]
	y_points = pca$x[,2]
	
	#Plot the first two principal components:
	title = paste('PCA Analysis -', classes[1], 'vs', classes[2])
	colors = sapply(Labels, label.color)
	ymin = min(y_points)
	ymax = max(y_points)
	xmin = min(x_points)
	xmax = max(x_points)
	xrange = abs(xmax - xmin)
	yrange = abs(ymax - ymin)
	
	pm = 0.1 #Margin to extend the axis ranges
		
	print(nrow(data))
	library(ggplot2)
	data = data.frame(x=x_points,y=y_points,id=ids)
	#p = qplot(data$x, data$y, data=data, colour=Labels, label=id, ylim=c(ymin-ymin*pm, ymax+ymax*pm), xlim=c(xmin-xmin*pm, xmax+xmax*pm))
	p = qplot(data$x, data$y, data=data, colour=Labels, label=id)
	p = p + opts(title = title, panel.background = theme_rect(colour = "black"))
	p = p + xlab('Principal Component 1')	
	p = p + ylab('Principal Component 2')
	p = p + geom_point(size = 3)
	p = p + opts(legend.position='right')
  
	if (label.points) {
		p = p + geom_text(size = 2, hjust=0, vjust=0, color='black')
	}
	p
}

#Color points based on their label
label.color = function(label) {
	classes = levels(label)
	if (label == classes[1]) {
		return('blue')
	} else {
		return('red')
	}
}

# ---------------------------------

#Get command line arguments:
args = commandArgs(trailingOnly = TRUE)
# if (length(args) == 2) {
	file_path = args[1]
	output_image = args[2]

	#Read Data:
	if (debug) {
		cat(paste("Using data in: ", file_path, "\n"))
	}
	orig_data <- read.csv(file_path, header=TRUE, strip.white=TRUE, sep=',')

	#Create plot:
	png(output_image, width = 800, height = 800, res = 120)
	plot.pca(orig_data)
	if (debug) {
		cat(paste("Saving image to: ", output_image, "\n"))
	}
	invisible(dev.off())
# } else {
# 	cat("Invalid usage! Use: Rscript pca.R <input_file_path> <output_image_file_path>\n")
# }