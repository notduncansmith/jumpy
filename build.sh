rm app.js
echo "#!/usr/bin/env node" >> app.js
coffee -pb --no-header app.coffee >> app.js
npm link
