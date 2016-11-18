.PHONY: informe

informe: inf/img
	(cd inf/ && ./gen_images.sh && pdflatex informe && biber informe && pdflatex informe && open informe.pdf)
