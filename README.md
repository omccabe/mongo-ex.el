mongo-ex.el
===========

This is a helper function for building mongo queries in emacs.

Edit your query in a js file (js2-mode is expected). Then when you're ready to test, C-c C-m to send the function under the cursor to a mongo CLI.

Set your preferred db with mongo-default-db.
Set mongo-command if you need something more exotic than "mongo" to start the CLI.

