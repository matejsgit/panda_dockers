# We need to make sure all the tags match also the online/dockerfile tags
$LONG_PREFIX = "abr-ijs/panda_dockers"
$SHORT_PREFIX = "ijs"

function build_and_tag
{
   docker build $IMAGE -t ${LONG_PREFIX}:$IMAGE
   docker tag ${LONG_PREFIX}:$IMAGE ${SHORT_PREFIX}:$IMAGE
}

$IMAGES = @(
 "kinetic-devel"
 "kinetic-gazebo"
 "panda-simulator"
 "gzweb"
 "panda-gzweb"
 "sim_controllers_interface"
)

foreach ($IMAGE in $IMAGES) {
  build_and_tag
}
