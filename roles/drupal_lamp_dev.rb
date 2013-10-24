name "lamp_drupal_dev"
description "A LAMP + Varnish + Memcached stack for Drupal similar to Mercury
with development tools."
run_list(
  "role[mysql_server]",
  "role[apache2_mod_php]",
  "role[drupal]",
  "recipe[drush::head]",
)
# TODO Add recipe to create dev sites via Drush make.
