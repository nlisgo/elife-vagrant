set INSTANCE_PATH /Users/ian/Dropbox/code/elife-local-dev/site-dumps/2013-06
set TARGET public
set DUMP drupal_prod_jnl_elife.June-19-2013.sql
cp $INSTANCE_PATH/settings.php $TARGET/
cp -r -f $INSTANCE_PATH/files $TARGET/
cp $INSTANCE_PATH/$DUMP $TARGET/
cp vagrant_elife_automate.sh $TARGET/
cp gen-elife.sql $TARGET/