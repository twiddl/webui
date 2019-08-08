import os

import argparse

import twiddl

import build/index
import build/statistics
import build/build_view
import build/list_view

proc build(twiddlPath:string, outputPath:string) =
  let
    env = openTwiddlEnv(twiddlPath)

  createDir(outputPath)

  writeFile(outputPath / "index.html", buildIndex(env))
  writeFile(outputPath / "list.html", buildListView(env))
  writeFile(outputPath / "statistics.html", buildStatistics(env))
  for build in env.builds:
    writeFile(outputPath / "build" & $build.id & ".html", buildBuildView(env, build))

when isMainModule:
  var p = newParser("twiddl_static_webui"):
    help("Generates static HTML pages for a twiddl environment")
    option("--path", help="Path of the twiddl environment", default=".")
    option("--output", help="Output path", default="./twiddl-static-webui")
  let opts = p.parse()
  build(opts.path, opts.output)
