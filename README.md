ruby version -- 2.3.4p301
rails version -- 5.1.3

DB: using postgresql# pattern-app-new

パターン本文で改行するときはseed_fuに\nをいれて"html_escape(@example.text).gsub(/\r\n|\r|\n/, "<br />").html_safe"みたいな感じで書く。
