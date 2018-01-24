#!/bin/sh
#
# Simple shell script to build map files for the NGINX web router
#
# for running outside of Docker
mapdir="maps"
srcdir="maps/src"
bkupmaps=/bin/true
# for real
#mapdir="/etc/nginx/maps"
#srcdir="${mapdir}/src"
#bkupmaps=/bin/false

# Simple helper shell functions
#
buedu_route () {
  echo "$1 $2 ;" >>"${mapdir}/sites.map"
}

buedu_redirect () {
  echo "$1 redirect ;" >>"${mapdir}/sites.map"
  echo "$1 $2 ;" >>"${mapdir}/redirects.map"
}

# ####
# Make a bkupfile if there already is one
#
for map in sites.map redirects.map ; do
  if $bkupmaps ; then
    if [ -f "${mapdir}/$map" ]; then
      bkupfile "${mapdir}/$map"
    fi
  fi
  echo "# This file generated by $0 using content in $srcdir" >"${mapdir}/$map"
done

# Now we go through all the configs in our source area and 
# do the load
#
for conf in ${srcdir}/*.conf ; do
  echo "Processing $conf"
  for map in sites.map redirects.map ; do
    echo "### Processing $conf " >>"${mapdir}/$map"
  done
  . "$conf"
done

# we need to pregenerate other erb config prior to enabling this
#exec /usr/sbin/nginx -t
