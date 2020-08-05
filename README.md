checkout trigger: https://support.circleci.com/hc/en-us/articles/360041503393-A-workaround-to-trigger-a-single-job-with-2-1-config

trigger a  circleci pipeline 
curl -u ${CIRCLECI_TOKEN}: -X POST https://circleci.com/api/v2/project/gh/m***n/y***o/pipeline --header "Content-Type: application/json" -d '{"branch":"master"}'

docker run --rm -it seemann/master:0.1.0 /app/hello
