# ! /usr/bin/R


############################################################
# 
# Run Correlation Analysis on a data set.
#
# Data format: 
# ID column labelled "ID"
# Label column labelled "Label" (Currently works best for 2 labels)
# Remaining data should be real-valued
# 
############################################################

debug = FALSE

#Run Correlation Analysis
plot.corr = function(orig_data, label.points=TRUE) {
	
	#Get IDs and Labels
	ids = orig_data$ID
	labels = orig_data$Label

	classes = levels(as.factor(labels))

	#Remove ID & Label from data matrix:
	data = orig_data[,-match('ID', names(orig_data))]
	data = data[,-match('Label', names(data))]

	#Run Correlation Analysis:
	data[is.na(data)] = 0
	corrs = c()
	num_classes = as.numeric(labels)
	for (i in 1:ncol(data)) {
		name = names(data)[i]
		col = data[,i]
		corrval = cor(col, num_classes)
		#corrs = append(corrs, corrval)
		corrs = rbind(corrs, data.frame(label=names(data)[i], cc=corrval))
	}
	#names(corrs) = names(data)
	
	#corrs = rev(sort(corrs))
	#corrs = corrs[with(corrs, order(cc)), ]

	corrs <- within(corrs, label <- factor(label, levels=names(sort(table(label),  decreasing=TRUE))))

	library(ggplot2)
	#barplot(corrs)
	print(corrs)
	qplot(label, data=corrs, geom="bar", weight=cc, binwidth=0.1)
	#p <- ggplot(corrs, aes(y=cc, x=label)) 
	#p <- p + geom_bar(position="dodge", stat="identity") 
	#p <- p + opts(axis.text.x = theme_text(angle = 45, hjust=1))
	#plot(p)
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
#if (length(args) == 2) {
	file_path = '/Users/eisner/insiliflo/code/metaboflo/tempcorr.csv'#args[1]
	output_image = '/Users/eisner/Desktop/test.png'#args[2]

	#Read Data:
	if (debug) {
		cat(paste("Using data in: ", file_path, "\n"))
	}
	orig_data <- read.csv(file_path, header=TRUE, strip.white=TRUE, sep=',')

	#Create plot:
	png(output_image, width = 800, height = 800, res = 120)
	plot.corr(orig_data)
	if (debug) {
		cat(paste("Saving image to: ", output_image, "\n"))
	}
	invisible(dev.off())
# } else {
# 	cat("Invalid usage! Use: Rscript corr.R <input_file_path> <output_image_file_path>\n")
# }