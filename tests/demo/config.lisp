(:title "LimaJS"
 :author "LimaJS"
 :domain "http://limajs.puercopop.com"
 :src-path #P"~/Projectos/NotLimaJS/"
 :deploy-method #'ncoleslaw:gh-pages
 :deploy-args "git@github.com:PuercoPop/NotLimaJS.it:"
 ;; Is the deployment configuration a good idea?
 :routing (("/" . (document (eql/uniq? :title "homepage")))
           ("/eventos/" . (document :index t :type 'event))
           ("/shoutouts/" . (documetnt :index t :type 'shoutout))))
