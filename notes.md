RUN

 to activate the dbt env


we need to make sure to give create schema access to the role 
if we enable 
tests:
    + store_failures


pwd env
    set -a
    source .env
    set +a

    echo $SNOWFLAKE_PASSWORD


