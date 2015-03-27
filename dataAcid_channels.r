#### Data on Acid - Experimenting with data mangling and noise channels ####

#files2 "a135t-profile.dat" "f123l-profile.dat" "f99y-profile.dat"  "i83v-profile.dat"  "l21v-profile.dat"  "l41f-profile.dat"  "v76a-profile.dat" 
for(i in 1:length(files2)){
	dataMat[i] = read.table(files2[i])
}


is.even <- function(x) x %% 2 == 0

plot(c(0,128),c(-200,200),col="white",main="Raw data")
for(i in 1:7){
	lines(c(1:128),dataMat[[i]],lwd=3,col=myrain[i])
}

quartz()
plot(c(0,128),c(0,21),col="white",main="Sqrt-fourier")
for(i in 1:7){
	fourier_this = fft(dataMat[[i]])
	fourier_this_re = Re(fourier_this)
	fourier_this_im = Im(fourier_this)
	a = sqrt(abs(as.double(fourier_this)))
	lines(c(1:128),a,lwd=3,col=myrain[i])
}

quartz()
// plot(c(0,128),c(-2000,2000),col="white",main="Mov-avg")
// for(i in 1:7){
// 	a = filter(dataMat[[i]],16)
// 	lines(c(1:128),a,lwd=3,col=myrain[i])
// }
// 

plot(c(0,128),c(-5000,2000),col="white",main="Cumulative")
for(i in 1:7){
	cumsum[1] = dataMat[[i]][1]
	for(j in 2:128){
		cumsum[j] = cumsum[j-1] + dataMat[[i]][j]
	}
	lines(c(1:128),cumsum,lwd=3,col=myrain[i])
}

quartz()
plot(c(0,128),c(-20,200),col="white",main="BitMangled")
for(i in 1:7){
	rawDat = writeBin(dataMat[[i]],raw(8))
	score = c(0)
	for(j in 1:128){
		startBit = (j-1)*8
		val_as_numeric = data.frame(as.numeric(rawDat[((j-1)*8):(startBit+8)]))
		val_as_numeric$even = is.even(as.numeric(rawDat[startBit+1:(startBit+8)]))
		for(k in 1:8){
			if(val_as_numeric$even[k]){
				score[j] = score[j]+val_as_numeric$as.numeric.rawDat.startBit...1..startBit...8...[k]
			}
		}
	}
	cat(score,"\n")
	lines(c(1:128),score,lwd=3,col=myrain[i])
}

// all together now

output = data.frame(series=rep(0,7*128),fourier_re=rep(0,7*128),fourier_im=rep(0,7*128),cumulative=rep(0,7*128))

for(i in 1:7){
	fourier_this = fft(dataMat[[i]])
	fourier_this_re = Re(fourier_this)
	fourier_this_im = Im(fourier_this)
	cumsum[1] = dataMat[[i]][1]
	for(j in 2:128){
		cumsum[j] = cumsum[j-1] + dataMat[[i]][j]
	}
	#	a = sqrt(abs(as.double(fourier_this)))
	output = data.frame(series=rep(1,128),sqrt(abs(fourier_this_re)),sqrt(abs(fourier_this_im)),cumsum)
	write.table(output,file=paste("output_sq_",i,".tdf",sep=''),sep="\t",row.names=F)	
}

