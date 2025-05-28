import shutil

src_fpath = "./_index-template.html"
target_fpath = "./docs/index.html"
shutil.copyfile(src_fpath, target_fpath)
print(f"Password-protection index copied to {target_fpath}")

