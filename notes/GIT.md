Triticumbase Repositories
=========================


SGN
---

**The main breeDBase web application**

**Location:** `/opt/breedbase/repos/sgn`

### Remotes
 
 - `origin`: [TriticeaeToolbox/sgn](https://github.com/TriticeaeToolbox/sgn)
 - `sgn`: [solgenomics/sgn](https://github.com/solgenomics/sgn)

### Local Branches

| local branch | upstream branch | notes |
|--------------|-----------------|-------|
| t3/master | origin/t3/master | **Main branch of the triticumbase instance.**  It contains T3-specific changes made to the sgn master branch. |
| master | origin/master | This branch should mirror the sgn master branch. |
| topic/xxx | origin/topic/xxx or sgn/topic/xxx | Development branches used for creating new features. |
| t3/xxx | origin/t3/xxx | T3-specific development branches. |

```
    sgn                               origin
   -----                             --------

             git pull sgn master        
   master --------------------------> master
     ^                                  |
     |                                  | git merge master
     |                                  |
     |                                  V
topic/xxx (sgn dev changes)         t3/master (T3 master branch)
                                        ^
                                        |
                                        | git merge t3/xxx
                                        |
                                     t3/xxx (T3-specific changes)

```

### Workflows

#### Updating from the SGN master branch

- **Change to the master branch**
    - `git checkout master`

- **Pull changes from the master branch of the solgenomics/sgn GitHub repository**
    - `git pull sgn master`

- **Restart the SGN web application**
    - `systemctl restart sgn`

- **Test the website**
    - Make sure there are no obvious problems
    
- **Update the master branch of the TriticeaeToolbox/sgn GitHub repository**
    - `git push origin master`

- **Merge the master branch into the t3/master branch**
    - `git checkout t3/master`
    - `git merge master`
    
- **Update the t3/master branch of the TriticeaeToolbos/sgn GitHub repository**
    - `git push origin t3/master`

- **Restart the SGN web application**
    - `systemctl restart sgn`

### Creating a branch that will be merged back into SGN

- **Create a branch from master**
    - `git checkout -b topic/xxx master`

- **Get the latest sgn master changes**
    - `git pull sgn master`

- **Make your changes**

- **Add and commit your changes**
    - `git add [files]`
    - `git commit -m [Message]`

- **Publish the branch**
    - `git push -u origin topic/xxx`

- **Create Pull Request**




triticum
--------

**T3-specific mason templates, catalyst controllers and static resources**

**Location:** `/opt/breedbase/repos/triticum`

### Remotes

 - `origin`: [TriticeaeToolbox/triticum](https://github.com/TriticeaeToolbox/triticum)

### Directories:

 - **mason/** 
    - T3-specific mason templates for changing website HTML

- **static_content/**
    - static content (such as images) used on the website
    - the contents of this directory are referenced in HTML as `/static_content/`
        - Example: `img/t3.png` is referenced in the HTML as `/static_content/img/t3.png`
    - `/home/production/cxgn/triticum/static_content` is symlinked from `/export/prod/public_triticum/static_content`, 
    which in turn is symlinked from `/home/production/cxgn/sgn/static/static_content`

 - **lib/Controller**
    - T3-specific Catalyst Controllers for adding new T3-specific HTTP requests / responses.
    - `/home/production/cxgn/triticum/lib/Controller` is symlinked from `/home/production/cxgn/sgn/lib/SGN/Controller/Triticum`


