# final output
all: upload/plot/dls.png

# db.R + [www] -> catch.csv + survey.csv + summary.csv
db/catch.csv: db.R
	Rscript --vanilla db.R
db/survey.csv: db.R
	Rscript --vanilla db.R
db/summary.csv: db.R
	Rscript --vanilla db.R

# input.R + catch.csv + survey.csv -> input.RData
input/input.RData: input.R db/catch.csv db/survey.csv
	Rscript --vanilla input.R

# model.R + input.RData -> dls.txt
model/dls.txt: model.R input/input.RData
	Rscript --vanilla model.R

# output.R + dls.txt -> dls.txt
output/dls.txt: output.R model/dls.txt
	Rscript --vanilla output.R

# upload.R + catch.csv + survey.csv + summary.csv + dls.txt
# ->         catch.csv + survey.csv + summary.csv + dls.txt
upload/input/catch.csv: upload.R db/catch.csv
	Rscript --vanilla upload.R
upload/input/survey.csv: upload.R db/survey.csv
	Rscript --vanilla upload.R
upload/input/summary.csv: upload.R db/summary.csv
	Rscript --vanilla upload.R
upload/output/dls.txt: upload.R output/dls.txt
	Rscript --vanilla upload.R

# xtra_plot.R + survey.csv + dls.txt -> dls.png
upload/plot/dls.png: xtra_plot.R upload/input/survey.csv upload/output/dls.txt
	Rscript --vanilla xtra_plot.R

clean:
# working dirs
	@rm -rf db
	@rm -rf input
	@rm -rf model
	@rm -rf output
	@rm -rf upload
