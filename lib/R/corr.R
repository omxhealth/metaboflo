############################################################
# 
# Run Correlation Analysis on a data set.
#
# Data format: 
# ID column labelled "subjectID"
# Label column labelled "Label" (Currently works for 2 or more classes)
# Remaining data should be real-valued
# 
############################################################

debug = FALSE

create.plot = function(orig_data, output_image='corr.csv', label.points=TRUE) {
	#Get IDs and Labels
	ids = orig_data$subjectID
	labels = as.factor(orig_data$Label)
	
	classes = levels(labels)

	#Remove ID & Label from data matrix:
	data = orig_data[,-match('subjectID', names(orig_data))]
	data = data[,-match('Label', names(data))]

	#Run Correlation Analysis:
	data[is.na(data)] = 0
	corrs = c()
	num_classes = as.numeric(labels)
	for (i in 1:ncol(data)) {
		name = names(data)[i]
		col = data[,i]
		corrval = cor(col, num_classes)
		corrs = rbind(corrs, data.frame(label=names(data)[i], cc=abs(corrval)))
	}

	#Sort by correlation coefficient:
	corrs$label = factor(corrs$label, levels=rev(as.character(corrs[with(corrs, order(cc)),]$label)))

	#Create plot:
	png(output_image, width = 700, height = 600, res = 120)
	
	library(ggplot2)
	p = ggplot(corrs, aes(y=cc, x=label, fill=label)) 
	p = p + geom_bar(position="dodge", stat="identity")
	p = p + opts(axis.text.x = theme_text(angle = 90, hjust=1), legend.position="none", 
							 panel.background = theme_rect(colour = "black"))
	# p = p + opts(title=paste('Metabolite Importance between', paste(classes[1], 'and', classes[2])), 
							
	p = p + xlab('Metabolites')
	p = p + ylab('Metabolite Importance')
	print(p)
	
	if (debug) {
		cat(paste("Saving image to: ", output_image, "\n"))
	}
	#invisible(dev.off())
	dev.off()
}


#Run Correlation Analysis
plot.corr = function(orig_data, output_image) {
	
	labels = orig_data$Label

	classes = levels(as.factor(labels))

	if (length(classes) == 2) {
		create.plot(orig_data, output_image=paste(output_image, '.png', sep=''))
	} else {
		orig.labels = as.character(orig_data$Label)
		counter = 1
		for (label in classes) {
			o.labels = orig.labels
			neg_label = paste("NOT", label)
			o.labels[o.labels != label] = neg_label
			orig_data$Label = o.labels
			
			create.plot(orig_data, output_image=paste(output_image, counter, '.png', sep=''))
			counter = counter + 1
		}
	}
}

# ---------------------------------

#Get command line arguments:
args = commandArgs(trailingOnly = TRUE)
if (debug) {
	cat(paste('Found', length(args), "arguments\n"))
}

#if (length(args) == 2) {
	file_path = args[1]
	output_image = args[2]
	
	#Read Data:
	if (debug) {
		cat(paste("Using data in: ", file_path, "\n"))
	}
	orig_data <- read.csv(file_path, header=TRUE, strip.white=TRUE, sep=',', check.names=FALSE)


	plot.corr(orig_data, output_image)

# } else {
# 	cat("Invalid usage! Use: Rscript corr.R <input_file_path> <output_image_file_path>\n")
# }
