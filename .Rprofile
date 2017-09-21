# options(repos=c(CRAN="http://cran.rstudio.com/"))
# options(repos = c(CRAN="http://cran.r-project.org"))

# options(matlab.path='/Applications/MATLAB_R2014b.app/bin')
# options(fsl.path='/usr/local/fsl')

options(
  swirl_data_dir = "~/Dropbox/Classes/swirl",
  swirl_user = "jmusche1"
)

options(max.print=1000)
# if (.Platform$GUI != "RStudio"){
if (Sys.getenv("TERM") == "xterm-256color") {
	req = require(colorout)
}



## For knitr bootstrap
## More info at http://www.rstudio.com/ide/docs/authoring/markdown_custom_rendering
# options(rstudio.markdownToHTML =
#   function(inputFile, outputFile) {
#     library(knitrBootstrap)
#     knit_bootstrap_md(input=inputFile, output=outputFile, code_style="Brown Paper", chooser=c("boot", "code"), show_code=FALSE)
#   }
# )
options(menu.graphics=FALSE)

# from 
# http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session
# improved list of objects
.ls.objects <- function (pos = 1, pattern, order.by,
                        decreasing=FALSE, head=FALSE, n=5) {
    napply <- function(names, fn) sapply(names, function(x)
                                         fn(get(x, pos = pos)))
    names <- ls(pos = pos, pattern = pattern)
    obj.class <- napply(names, function(x) as.character(class(x))[1])
    obj.mode <- napply(names, mode)
    obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
    obj.size <- napply(names, object.size)
    obj.dim <- t(napply(names, function(x)
                        as.numeric(dim(x))[1:2]))
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
    out <- data.frame(obj.type, obj.size, obj.dim)
    names(out) <- c("Type", "Size", "Rows", "Columns")
    if (!missing(order.by))
        out <- out[order(out[[order.by]], decreasing=decreasing), ]
    if (head)
        out <- head(out, n)
    out
}
# shorthand
lsos <- function(..., n=10) {
    .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}

