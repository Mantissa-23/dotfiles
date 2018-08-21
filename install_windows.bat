@echo off
set /p uname="Enter Username: "
mklink /D C:\Users\%uname%\AppData\Local\nvim C:\Users\%uname%\.config\nvim
