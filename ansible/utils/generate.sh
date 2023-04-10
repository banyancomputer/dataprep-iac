
# Get the arguments
SIZE=$1
WIDTH=$2
DEPTH=$3
LIST=$4
OUTPUT_PATH=$5
IFTTT_TEST_WEBHOOK_KEY=$6

for strategy in $(echo $LIST | tr "," " "); do
    fake-file \
     -s $SIZE \
     -w $WIDTH \
     -d  $DEPTH \
     --strategy "$strategy" \
     -o $OUTPUT_PATH \
     -v
done
curl -X POST -H \"Content-Type: application/json\" -d \
 '{\"Title\": \"Generate done\"}' \
  https://maker.ifttt.com/trigger/dataprep_event/with/key/$IFTTT_TEST_WEBHOOK_KEY;