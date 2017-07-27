cdd() {
    cd `dirname ${1}`
}

pdf2latex2()
{   
    for arg;   
    do 
        echo "$arg => ${arg/eps/pdf}";     
        pdf2latex $arg;   
    done 
}

function edit()
{
    subl  $@ 2>/dev/null
}

function bibifonly {
    if [ -e ${1}.aux ]; \
    then \
        bibtex ${1}; \
    fi; 
}

function gacp {
    git pull
    git add --all .
    git ci -m "${1}"
    if [ -n "${2}" ]; then 
        echo "Tagging Commit"
        git tag "${2}" 
        git push origin "${2}"
    fi
    # else
        git push origin
    # fi
}

function dgacp {
    rm -r inst/dramms/*
    gacp "${1}"
}

function cgacp {
    rm -r inst/camino/*
    rm -r src/camino
    gacp "${1}"
}

function mgacp {
    rm -r inst/mass/*
    rm -r src/Process_Files.R
    gacp "${1}"
}

function none_docker_images {
    docker images | grep "^<none>" | awk '{print $3}'
}

function burn_docker {
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    docker volume rm $(docker volume ls |awk '{print $2}')
    rm -rf ~/Library/Containers/com.docker.docker/Data/*
}

function docker_reattach {
    docker start ${1} && docker attach ${1}
}


function stopped_docker {
    docker ps -aq
}

function remove_stopped_docker {
    stopped_docker | xargs docker rm
}



# function deployApp {
#     rsync ./ui.R ./server.R $shinyuser:/srv/shiny-server/"${1}"
# }

# function deployAppAll {
#     rsync --recursive --progress ./* $shinyuser:/srv/shiny-server/"${1}"
# }

function deployApp {
    rsync ./ui.R ./server.R $jenig:~/shinyapps/"${1}"
}

function deployAppAll {
    rsync --recursive --progress ./* $jenig:~/shinyapps/"${1}"
}


function render {
    Rscript -e "rmarkdown::render('${1}')"
}

function render_html {
    render ${1}
    res=`echo ${1} | awk '{ gsub("[.]Rmd$", ".html"); print }'`
    open $res
}

function render_pdf {
    render ${1}
    res=`echo ${1} | awk '{ gsub("[.]Rmd$", ".pdf"); print }'`
    open $res
}

# alias doc='R -q -e "devtools::document()"'
alias document_reg='R -q -e "devtools::document()"'
alias document='R -q -e "devtools::document(roclets=c(\"rd\", \"collate\", \"namespace\", \"vignette\"))"'
alias build='R -q -e "devtools::build()"'
alias check='R -q -e "devtools::check(args = c(\"--as-cran\"), build_args = c(\"--resave-data\"))"'

alias dev_doc='R -q -e "devtools::document()"'
alias dev_check='R -q -e "devtools::check(args = c(\"--as-cran\"), build_args = c(\"--resave-data\"))"'
alias dev_build='R -q -e "devtools::build()"'
alias dev_install='R -q -e "devtools::install()"'
alias build_vignettes='R -q -e "devtools::build_vignettes()"'


function knit2html {
    R -e "library(knitr); knit2html('$1')";
}

function knit {
    R -e "library(knitr); knit('$1')";
}

function knit2pdf {
    R -e "library(knitr); knit2pdf('$1')";
}

function ortho2 {
    R -e "tfile = tempfile(fileext = '.png'); png(tfile); neurobase::ortho2('${1}'); dev.off(); system(paste0('open ', tfile)); Sys.sleep(2);"
}
