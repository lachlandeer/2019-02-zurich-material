## Workflow: SWC/DC Slides
##
## author: @lachlandeer
##

# --- User Decision --- #

include_shell_ex = False

# --- Libraries --- #
import os, re

# --- Pandoc version --- #

def get_pdf_engine():
    pandoc_version = os.popen("pandoc --version").read().splitlines()[0]
    version_number = int(re.search('\d', pandoc_version).group(0))
    print('Working with pandoc version:', version_number)
    if version_number == 1:
        pdf_engine  = "--latex-engine=pdflatex"
    else:
        pdf_engine = "--pdf-engine=pdflatex"
    return pdf_engine

PDF_ENGINE = get_pdf_engine()

# --- Set up Dictionary of content --- #

FIGURES = glob_wildcards("figures/{iFigure}.pdf").iFigure

if include_shell_ex == True:
    SECTIONS = ["preliminaries", "unix_ex"]
else:
    SECTIONS = ["preliminaries"]

# --- Build Rules --- #

rule build_slides:
    input:
        style_file = "beamerthemeLagonBleu.sty",
        style_tex  = "style.tex",
        latex_preamble = "preamble.tex",
        template   = "template.beamer" ,
        img_convert = "pandoc-svg.py",
        #biblio = "refs.bib",
        #bibclass = "chicago.csl",
        logo = "figures/logo/UZH_logo_borderGreen.png",
        #figures = expand("figures/{iFigure}",      iFigure  = FIGURES),
        metadata = "slide_config.yaml",
        section = expand("sections/{iSection}.md",  iSection = SECTIONS)
    output:
        "out/slides.pdf"
    shell:
        "pandoc -t beamer -H preamble.tex \
            {input.metadata} \
            {input.section} \
            --filter=pandoc-svg.py \
            --slide-level 2 \
            {PDF_ENGINE} \
            --highlight-style zenburn \
            --template=template.beamer \
            -o {output}"

rule pdf_clean:
    shell:
        "rm out/*.pdf"
