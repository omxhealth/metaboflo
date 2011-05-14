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
	labels = orig_data$Label

	classes = levels(as.factor(labels))

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
	colors = sapply(labels, label.color)
	ymin = min(y_points)
	ymax = max(y_points)
	xmin = min(x_points)
	xmax = max(x_points)
	xrange = abs(xmax - xmin)
	yrange = abs(ymax - ymin)
	pm = 0.15 #Percent margin to extend the axis ranges
	plot(x_points, y_points, col=colors, main=title,
			 xlab="Principal Component 1",ylab="Principal Component 2",#yaxt='n',xaxt='n',
			 ylim=c(ymin-yrange*pm, ymax+yrange*pm), xlim=c(xmin-xrange*pm, xmax+xrange*pm))
	legend('topright', title='Labels', classes, fill = c('blue', 'red'), horiz = TRUE)

	#Add IDs to points:
	if (label.points) {
		text(x_points, y_points, ids, cex=0.7, pos=4, col=colors)
	}
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
if (length(args) == 2) {
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
} else {
	cat("Invalid usage! Use: Rscript pca.R <input_file_path> <output_image_file_path>\n")
}