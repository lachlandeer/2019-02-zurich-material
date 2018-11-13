
## --- Set up Dictionary of content --- ##

SECTIONS = ["content"]

## --- Build Rules --- ##

rule build_slides:
    input:
        style_file = "beamerthemeLagonBleu.sty",
        style_tex  = "style.tex",
        latex_preamble = "preamble.tex"
        template   = "template.beamer" ,
        #biblio = "refs.bib",
        #bibclass = "chicago.csl",
        logo = "figures/logo/by-nc-sa-ccLicense.eps",
        #figures = expand("figures/{iFigure}",      iFigure  = FIGURES),
        metadata = "slide_config.yaml",
        section = expand("sections/{iSection}.md",  iSection = SECTIONS)
    output:
        "out/slides.pdf"
    shell:
        "pandoc -t beamer -H preamble.tex \
            {input.metadata} \
            {input.section} \
            --filter pandoc-citeproc \
            --slide-level 2 \
            --latex-engine=pdflatex \
            --highlight-style zenburn \
            --template=template.beamer \
            -o {output}"

rule pdf_clean:
    shell:
        "rm out/*.pdf"
