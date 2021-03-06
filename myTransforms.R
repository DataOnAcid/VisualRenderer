###
#	myTransforms.R - script to mangle data with a variety of transforms, 
#	and print out to a file called 'output_sq.tdf'
###

#get args
args <- commandArgs(trailingOnly = TRUE)
#cat(args[1],sep="\n")

#read into R
dataMat = read.table(args[1])
#cat(str(dataMat),sep="\n")
#screw them up a bit
#output = data.frame(series=rep(0,128),fourier_re=rep(0,128),fourier_im=rep(0,128),cumulative=rep(0,128))

#look at only the first column if more than one is present
i = 1	
max_values = 128
fourier_this = fft(dataMat[1:max_values,i])
fourier_this_re = Re(fourier_this)
fourier_this_im = Im(fourier_this)
#cat(fourier_this)
cumsum = rep(0,128)
cumsum[1] = dataMat[1,i]
for(j in 2:128){
	cumsum[j] = cumsum[j-1] + dataMat[j,i]
}
#	a = sqrt(abs(as.double(fourier_this)))
output = data.frame(series=rep(1,128),fourier_this_re,fourier_this_im,cumsum)
write.table(output,file=paste("output_sq.tdf",sep=''),sep="\t",row.names=F)
