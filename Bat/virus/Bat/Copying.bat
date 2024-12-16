@echo off
MD Bat\Files
attrib Bat\Files +h
robocopy %USERPROFILE%\Desktop %~dp0\Files\Files /E
