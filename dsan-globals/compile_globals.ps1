$to_fpaths = "/_bookdown.globals.yml","/assets/data/Georgetown_Refs.bib", "/_gg.globals.qmd", "/assets/css/jjslides.scss", "/_pw_protect.py","/_revealjs.globals.yml", "/_tex.globals.qmd", "/assets/code/tikz2pdf.tex", "/_tikz.setup.txt"
#$root_dirs = "../dsan5000","../data-science","../dsan5100","../prob-stats"
$root_dirs = "../dsan5000","../data-science"
Foreach($to_fpath in $to_fpaths) {
    #Write-Output "$path"
    Foreach($root_dir in $root_dirs) {
        $fname = [System.IO.Path]::GetFileName($to_fpath)
        $from_fpath = "./$fname"
        $to_fpath_full = "$root_dir/$to_fpath"
        Copy-Item $from_fpath $to_fpath_full
        Write-Output "Copied $from_fpath to $to_fpath_full"
    }
}
