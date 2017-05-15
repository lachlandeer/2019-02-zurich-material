
## --- Set up Dictionary of content --- ##

SECTIONS = ["content"]

## --- Build Rules --- ##

rule buildSlides:
    input:
        styleFile = "beamerthemeLagonBleu.sty",
        latexPreamble = "preamble.tex",
        #biblio = "refs.bib",
        #bibclass = "chicago.csl",
        logo = "figures/logo/by-nc-sa-ccLicense.eps",
        #figures = expand("figures/{iFigure}",      iFigure  = FIGURES),
        metaData = "slideConfig.yaml",
        section = expand("sections/{iSection}.md",  iSection = SECTIONS)
    output:
        "out/slides.pdf"
    shell:
        "pandoc -t beamer -H preamble.tex \
            {input.metaData} \
            {input.section} \
            --filter pandoc-citeproc \
            --slide-level 2 \
            --latex-engine=pdflatex \
            -o {output}"

rule pdfclean:
    shell:
        "rm output/*.pdf"
