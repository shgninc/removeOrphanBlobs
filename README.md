# removeOrphanBlobs
By this bash script you just send the path of registry path and script check the path whethear is exsit or orphan via database and then delete the orphans.

A common problem in docker images registry, special in go Harbor, There is a concept, named, orphan blobs which, there are some blobs of image layer files in registry that is not in harbor database.
So, Harbor occupide disk, which are not accesable and useabl. In some way, harbor delete them by GC, but in some cases GC can not find the blobs in database (so named them orphan) and ignore them.

By this bash script I check if the blobs dose not exist in database, delete it.
