
generate.example = function(is.positive) {
	#name, gain, loss
	dists = matrix(c('Adipate','Glucose','Quinolinate','Myo-inositol','Valine','Succinate','Betaine','Leucine','N,N-dimethylglycine','3-Hydroxyisovalerate','Creatine', 6.2, 92.9, 26.7, 30.5, 13.2, 8.6, 27.3, 9, 9.2, 5.3, 18.6, 16.1, 397, 76, 131.9, 39.8, 50.2, 112.5, 24.3, 30.4, 21.3, 87.4), ncol=3)

	example = c()
	for (i in 1:nrow(dists)) {
		met = dists[i, 1]
		if (is.positive) {
			mean = as.numeric(dists[i, 3])
		} else {
			mean = as.numeric(dists[i, 2])
		}
		
		conc = rnorm(1, mean, mean/2)
		if (conc < 0) {
			conc = 0.0
		}
		conc = round(conc, digits=2)
		example = rbind(example, data.frame(met=met, concentration=conc))
	}
	
	return(example)
}

output.dir = '../tasks/demo/data_files/'

pos.ids = c(1, 3, 5, 6, 10, 13, 15, 16)
control.ids = c(2, 4, 7, 8, 9, 11, 12, 14, 17)

for (i in 1:length(pos.ids)) {
	id = pos.ids[i]
	example = generate.example(TRUE)
	write.table(example, paste(output.dir, id, '.csv', sep=''), sep=',', row.names=FALSE, col.names=FALSE)
}

for (i in 1:length(control.ids)) {
	id = control.ids[i]
	example = generate.example(FALSE)
	write.table(example, paste(output.dir, id, '.csv', sep=''), sep=',', row.names=FALSE, col.names=FALSE)
}