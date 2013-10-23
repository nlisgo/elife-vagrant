name "lamp_varnish_drupal_dev"
description "A LAMP + Varnish + Memcached stack for Drupal similar to Mercury
with development tools."
run_list(
  "role[mysql_server]",
  "role[apache2_mod_php]",
  
  #"role[apache2_backend]",
  
  "role[drupal]",
  "recipe[drush::head]",

  #"role[drupal_dev]",
  #"role[memcached]",
  #"role[varnish_frontend]",
  #"recipe[drupal::drupal_apps]",
)
# TODO Add recipe to create dev sites via Drush make.
