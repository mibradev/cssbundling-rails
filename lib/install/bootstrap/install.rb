say "Install Bootstrap with Popperjs/core"
copy_file "#{__dir__}/application.bootstrap.scss",
   "app/assets/stylesheets/application.bootstrap.scss"
run "yarn add sass bootstrap @popperjs/core"

if Rails.root.join("app/javascript/application.js").exist?
  say "Appending Bootstrap JavaScript import to default entry point"
  append_to_file "app/javascript/application.js", %(import * as bootstrap from "bootstrap"\n)
else
  say %(Add import * as bootstrap from "bootstrap" to your entry point JavaScript file), :red
end

say "Add build:css script"
build_script = "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"

if (`npx -v`.to_f < 7.1 rescue "Missing")
  say %(Add "scripts": { "build:css": "#{build_script}" } to your package.json), :green
else
  run %(npm set-script build:css "#{build_script}")
end
